# AGENTS.md — Instruções para agentes de IA

Este repositório é um acervo de **49 projetos de IA de código aberto**, organizados
em **uma pasta por projeto**, mantidos como snapshot do código (sem o histórico Git
original de cada projeto).

## Estrutura

| Caminho | O que é |
|---|---|
| `README.md` | Visão geral do acervo |
| `CATALOGO.md` | Catálogo dos 49 projetos por categoria e por tarefa |
| `LINKS.md` | Links dos materiais de origem e dos repositórios no GitHub |
| `MATERIAIS/` | Resumos dos materiais de origem (ex.: claude-100-egm.md) |
| `repos.txt` | Lista `owner/repo` com a origem de cada pasta |
| `montar_repo.sh` | Script usado para montar este repositório |
| `<NomeDoProjeto>/` | Código-fonte de cada um dos 49 projetos |

## Regras para a IA

1. **Antes de procurar um projeto**, leia `CATALOGO.md` e `LINKS.md`.
2. Cada pasta de projeto é um **snapshot de terceiros**: não altere o código sem
   pedido explícito do usuário.
3. Para instruções específicas de um projeto, leia o `README`/`AGENTS.md`
   **dentro da pasta daquele projeto**.
4. Créditos e origem: consulte `LINKS.md` e `repos.txt`. Os autores originais
   estão nos repositórios do GitHub indicados.
5. Não adicione credenciais, tokens ou arquivos grandes (> 50 MB) ao repositório.
6. Este repositório serve como **base de consulta e instrução**; trate o conteúdo
   das pastas como somente leitura, salvo instrução em contrário.

## Como localizar um projeto

- Por tarefa (imagem, vídeo, voz, texto, automação): use `CATALOGO.md`.
- Pelo nome ou link original: use `LINKS.md` ou `repos.txt`.
