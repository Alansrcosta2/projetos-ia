# Instruções — publicar no GitHub pelo servidor (tmux + opencode)

## Situação

- O GitHub bloqueou temporariamente a **criação de repositórios** na conta (`You have created too many repositories, too quickly`). É um limite secundário da conta; passa sozinho (geralmente em ~1 hora).
- O servidor já tem `gh`/git autenticados na sua conta — então é de lá que vamos publicar.
- Este pacote já contém `CATALOGO.md`, `LINKS.md`, `MATERIAIS/` e o script que monta o repositório único.

## Pré-requisitos no servidor

- `git` e `gh` instalados
- `gh auth status` mostrando a conta `Alansrcosta2` logada
- ~6 GB de espaço livre

## Passo a passo

1. Copie esta pasta para o servidor (scp, rsync ou upload).
2. Abra o tmux:
   ```bash
   tmux new -s projetos
   ```
3. Entre na pasta:
   ```bash
   cd ~/projetos-ia-repo
   ```
4. Rode o script (ou peça ao opencode para rodar):
   ```bash
   bash montar_repo.sh
   ```
5. Acompanhe o log em outro painel do tmux (`Ctrl+b %` divide):
   ```bash
   tail -f publicar.log
   ```

## O que o script faz

1. Clona os 49 repositórios (raso) listados em `repos.txt`, se ainda não existirem.
2. Remove o `.git` interno de cada pasta (snapshot do código).
3. Cria `Alansrcosta2/projetos-ia` (público). Se o GitHub ainda estiver bloqueando, espera 5 min e tenta de novo (até 24 vezes / ~2 h).
4. Faz commit e push **pasta por pasta** (um projeto por commit/push) para não estourar o limite de 2 GB por push.
5. Ao final, imprime o link do repositório.

## Observações

- Pode rodar de novo com segurança: pastas já clonadas são puladas e pushes pendentes são concluídos.
- Se um push falhar, o script tenta 3 vezes e segue; rode novamente depois.
- O repositório terá ~3–4 GB (snapshot sem histórico). É o preço de ter tudo em um único repo.
- Para repositório privado, troque `--public` por `--private` no script.
- O `publicar.log` não entra no repositório (`.gitignore`).

## Se ainda estiver bloqueado

O script já espera e insiste. Se quiser testar manualmente:

```bash
gh repo view Alansrcosta2/projetos-ia
gh repo create Alansrcosta2/projetos-ia --public
```
