# Rebase Labs
Uma app web para listagem de exames médicos.

## Tecnologias 
- Sinatra
- Puma
- Postgres

## Pré-requisitos
- Docker

## Para Executar 
1. Clone o repositório e acesse o projeto.

2. **Importante:** Renomeie o arquivo `.env.example` para `.env`.

3. Execute `$ bin/dev` para iniciar a aplicação. <br>
Isso inicia os contêineres do banco de dados e servidor em rede. <br>
Endereço padrão: http://localhost:3000/.

4. Para encerrar: <br>
Pressione Ctrl + C no terminal onde o Docker Compose está em execução. <br>
Em seguida, execute `$ docker-compose down` para remover os contêineres.

## Documentação da API

```shell
GET /tests <br>
```

```json
  {
    "id": "1",
    "cpf": "048.973.170-88",
    "nome_paciente": "Emilly Batista Neto",
    "email_paciente": "gerald.crona@ebert-quigley.com",
    "data_nascimento_paciente": "2001-03-11",
    "endereco_rua_paciente": "165 Rua Rafaela",
    "cidade_paciente": "Ituverava",
    "estado_paciente": "Alagoas",
    "crm_medico": "B000BJ20J4",
    "crm_medico_estado": "PI",
    "nome_medico": "Maria Luiza Pires",
    "email_medico": "denna@wisozk.biz",
    "token_resultado_exame": "IQCZ17",
    "data_exame": "2021-08-05",
    "tipo_exame": "hemácias",
    "limites_tipo_exame": "45-52",
    "resultado_tipo_exame": "97"
  }
```
Retorna um JSON com listagem de todos os exames cadastrados
