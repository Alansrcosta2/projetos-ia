# Como usar este material com IA

Este repositório **não é um aplicativo pronto**: é um acervo de código e instruções.
A IA aproveita o material de três formas principais.

## 1. Como agente de código (recomendado)

Abra a **pasta raiz** do repositório no OpenCode, Claude Code, Cursor, Codex, etc.
O agente lê o `AGENTS.md` da raiz automaticamente e passa a tratar o repositório
inteiro como contexto.

**Prompt de exemplo:**

> Leia `AGENTS.md`, `CATALOGO.md` e `LINKS.md`. Quero criar vídeos a partir de
> texto. Escolha o projeto mais adequado, explique como instalar e rodar no meu
> sistema e monte um passo a passo.

O agente vai:
1. consultar o catálogo;
2. escolher a pasta do projeto;
3. ler o `README`/`AGENTS.md` interno daquele projeto;
4. propor instalação, comandos e testes.

## 2. Como base de conhecimento (RAG)

Se você quer um assistente que **responda perguntas** sobre o material:

1. Indexe os arquivos `.md` (`README.md`, `CATALOGO.md`, `LINKS.md`,
   `MATERIAIS/` e os `README.md` dentro de cada projeto).
2. Gere embeddings e use um banco vetorial (opcional).
3. Faça perguntas como:
   - "Qual projeto serve para remover fundo de imagem?"
   - "Quais projetos trabalham com voz?"
   - "Como instalo o ComfyUI?"

Não é obrigatório usar banco vetorial: para 49 projetos, `grep` e leitura direta
dos `.md` já resolvem na maioria dos casos.

## 3. Como referência via GitHub

Aponte o link para uma IA com acesso à web:

`https://github.com/Alansrcosta2/projetos-ia`

Ela pode ler o `README.md`, o `CATALOGO.md`, o `LINKS.md` e os arquivos de cada
pasta diretamente pelo GitHub.

## Preciso de Docker?

- **Para a IA ler e explicar o material:** não.
- **Para executar um projeto:** depende do projeto. Alguns pedem Docker, outros
  rodam direto com Python/Node. Consulte o `README` **dentro da pasta do projeto**.
- **Para RAG:** não é obrigatório; Docker só se você quiser subir um banco
  vetorial (ex.: Qdrant) ou uma interface (ex.: Open WebUI).

## Fluxo recomendado

1. `CATALOGO.md` → descubra qual projeto resolve a tarefa.
2. `LINKS.md` / `repos.txt` → veja a origem e os créditos.
3. Pasta do projeto → leia o `README`/`AGENTS.md` interno.
4. Rode conforme as instruções do próprio projeto.

## Prompts prontos

- "Leia `AGENTS.md` e `CATALOGO.md`. Qual projeto usar para gerar imagem a partir
  de texto? Explique o passo a passo de instalação."
- "Compare os projetos de voz (`TTS`, `F5-TTS`, `bark`, `chatterbox`) e recomende
  um para clonagem de voz em português."
- "Abra a pasta `n8n/` e resuma como rodar localmente com Docker."
- "Monte um roteiro de instalação para o `ComfyUI` no meu sistema."
- "Quais projetos deste repositório servem para automação de navegador?"

## Arquivos que a IA deve ler primeiro

| Ordem | Arquivo | Para quê |
|---|---|---|
| 1 | `AGENTS.md` | regras gerais do repositório |
| 2 | `CATALOGO.md` | mapa de tarefas → projetos |
| 3 | `LINKS.md` | origem e créditos |
| 4 | `<Projeto>/README.md` | instruções específicas do projeto |
