# EGM do Google — instalação, os 7 comandos e o passo a passo

Fonte: https://andrelug.com/materiais/claude-100
Repositório oficial: https://github.com/google/elephant-goldfish-model
Licença: Apache 2.0 (plugin gratuito e de código aberto)

O **Elephant Goldfish Model (EGM)** faz o agente de IA escrever um plano e revisá-lo antes de programar.

## Os 3 papéis

| Papel | Sabe o quê | Faz o quê |
|---|---|---|
| Elefante | O projeto, os requisitos e as decisões | Explora o problema e escreve a especificação |
| Peixinhos | Só o documento, sem a conversa | Acham suposições, pontos confusos e riscos |
| Você | Os objetivos e os limites | Decide os trade-offs e aprova o que vai ser construído |

## Instalar

**Claude Code**
```
claude plugin marketplace add google/elephant-goldfish-model
claude plugin install egm@egm
```

**Codex**
```
codex plugin marketplace add google/elephant-goldfish-model
codex plugin add egm@egm
```

**Antigravity (CLI)**
```
agy plugin install https://github.com/google/elephant-goldfish-model
```

Depois, abra uma sessão nova. No Claude Code e no Antigravity os comandos têm o prefixo `/egm:` (ex.: `/egm:egm-brainstorm`). Funciona também no Claude Cowork e no ChatGPT Work (veja o guia de instalação do repositório).

A revisão precisa que o agente consiga criar subagentes novos. O Claude Code faz isso. Se a ferramenta não consegue, o EGM para a revisão.

## Os 7 comandos

| Comando | Para quê |
|---|---|
| `egm-brainstorm` | Testa uma ideia com 6 olhares de peixinho e salva o `concepts_brief.md` |
| `egm-draft` | Transforma o resumo num documento de design, seção por seção |
| `egm-review` | Revisa o design em 5 etapas: visão de longe, compreensão, crítica do design, nova visão de longe e "pronto pra construir?" |
| `egm-resolve` | Passa pelas críticas com você até concordarem no que muda |
| `egm-review-loop` | Roda um grupo de revisores montado por você para uma tarefa |
| `egm-bootstrap` | Cria ou atualiza a documentação de um projeto que já existe |
| `egm-drift-report` | Compara os documentos com o código e mostra onde se separaram |

## Exemplo de uso

1. `/egm:egm-brainstorm Add webhook delivery to this project.` — os peixinhos perguntam: e se a entrega falhar? E se o mesmo evento chegar duas vezes?
2. `/egm:egm-draft` vira o `design_draft.md`, e você comenta cada seção.
3. `/egm:egm-review design_draft.md` traz muito retorno, de propósito. Pegue o que importa e ignore o resto.
4. Aprovou o documento? Aí peça para o agente construir.

## Quando não vale a pena

- **Bug pequeno e claro:** use o seu jeito normal.
- **Produtividade:** o próprio FAQ diz que terminar o processo não prova ganho de produtividade. Compare o tempo e o retrabalho nas suas tarefas.
- **Status:** não é um produto oficial do Google.

## Por onde começar esta semana

1. Faça o processo 1 ou 2 vezes **na mão**, conversando com a IA. O guia recomenda isso antes de instalar, é de graça e não precisa instalar nada.
2. Instale com os 2 comandos e teste numa funcionalidade que você ia mesmo construir.
3. Compare com o jeito que você faria antes.

Fontes: README, `docs/getting_started.md` e `docs/faq.md` do repositório. Ensaio original: "Elephants, Goldfish, and the New Golden Age of Software Engineering", de Dave Rensin.
