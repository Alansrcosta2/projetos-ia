#!/usr/bin/env bash
set -uo pipefail

USER_NAME="${GH_USER:-Alansrcosta2}"
REPO_NAME="${GH_REPO:-projetos-ia}"
REPO_URL="https://github.com/${USER_NAME}/${REPO_NAME}.git"
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG="${BASE_DIR}/publicar.log"

exec > >(tee -a "$LOG") 2>&1

echo "=================================================="
echo " Publicar ${USER_NAME}/${REPO_NAME}"
echo " Pasta: ${BASE_DIR}"
echo " Data:  $(date)"
echo "=================================================="

if ! command -v git >/dev/null 2>&1; then echo "ERRO: git nao instalado"; exit 1; fi
if ! command -v gh >/dev/null 2>&1; then echo "ERRO: gh nao instalado"; exit 1; fi
if ! gh auth status >/dev/null 2>&1; then echo "ERRO: gh nao autenticado. Rode: gh auth login"; exit 1; fi

mapfile -t repos < <(grep -v '^[[:space:]]*#' "${BASE_DIR}/repos.txt" | grep -v '^[[:space:]]*$')

if [ "${#repos[@]}" -eq 0 ]; then echo "ERRO: repos.txt vazio"; exit 1; fi

echo ""
echo "== 1/4) Clonando ${#repos[@]} projetos (raso) =="
for r in "${repos[@]}"; do
  name="${r##*/}"
  if [ -d "${BASE_DIR}/${name}" ] && [ -n "$(ls -A "${BASE_DIR}/${name}" 2>/dev/null)" ]; then
    echo "SKIP clone ${name}"
  else
    if git clone --depth 1 --single-branch --no-tags "https://github.com/${r}.git" "${BASE_DIR}/${name}"; then
      echo "OK clone ${name}"
    else
      echo "FALHA clone ${r}"
      continue
    fi
  fi
  rm -rf "${BASE_DIR}/${name}/.git"
done

echo ""
echo "== 2/4) Garantindo o repositorio no GitHub =="
tries=0
while ! gh repo view "${USER_NAME}/${REPO_NAME}" >/dev/null 2>&1; do
  if gh repo create "${USER_NAME}/${REPO_NAME}" --public --description "49 projetos de IA do GitHub (mapa-100 + mapa-101)" >/dev/null 2>&1; then
    echo "Repositorio criado: ${REPO_URL}"
    break
  fi
  tries=$((tries + 1))
  if [ "${tries}" -ge 24 ]; then
    echo "GitHub ainda bloqueando a criacao apos ${tries} tentativas (~2h). Rode o script de novo mais tarde."
    exit 1
  fi
  echo "GitHub bloqueou (tentativa ${tries}). Aguardando 5 min..."
  sleep 300
done

echo ""
echo "== 3/4) Preparando o git local =="
cd "${BASE_DIR}" || exit 1
if [ ! -d .git ]; then git init -b main; fi
git config user.name >/dev/null 2>&1 || git config user.name "${USER_NAME}"
git config user.email >/dev/null 2>&1 || git config user.email "${USER_NAME}@users.noreply.github.com"
if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "${REPO_URL}"
else
  git remote add origin "${REPO_URL}"
fi

push_retry() {
  local n=0
  until git push -u origin main; do
    n=$((n + 1))
    if [ "${n}" -ge 3 ]; then return 1; fi
    echo "      retry push (${n})..."
    sleep 30
  done
  return 0
}

git add -A
if git diff --cached --quiet; then
  echo "Commit inicial: nada novo"
else
  git commit -m "Catalogo, links e materiais" >/dev/null
  echo "Commit inicial criado"
fi
if ! push_retry; then echo "FALHA no push inicial"; exit 1; fi

echo ""
echo "== 4/4) Enviando cada projeto (commit + push por pasta) =="
fail=0
i=0
total="${#repos[@]}"
for r in "${repos[@]}"; do
  i=$((i + 1))
  name="${r##*/}"
  if [ ! -d "${BASE_DIR}/${name}" ]; then
    echo "[${i}/${total}] PULANDO ${name} (pasta ausente)"
    fail=$((fail + 1))
    continue
  fi
  git add "${name}"
  if git diff --cached --quiet; then
    echo "[${i}/${total}] SEM MUDANCA ${name}"
  else
    git commit -m "Add ${name}" >/dev/null
    echo "[${i}/${total}] commit ${name}"
  fi
  if push_retry; then
    echo "[${i}/${total}] OK ${name}"
  else
    echo "[${i}/${total}] FALHA push ${name}"
    fail=$((fail + 1))
  fi
done

push_retry >/dev/null 2>&1 || true

echo ""
echo "=================================================="
echo " FIM — falhas: ${fail}"
echo " Repositorio: https://github.com/${USER_NAME}/${REPO_NAME}"
echo " Data: $(date)"
echo "=================================================="
