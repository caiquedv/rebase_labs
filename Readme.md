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

2. Execute `$ bin/dev` para iniciar a aplicação. <br>
Isso inicia os serviços do banco de dados e servidor. <br>

3. Para encerrar: <br>
Pressione Ctrl + C no terminal onde o Docker Compose está em execução. <br>
(Opcional) Execute `$ docker-compose down --volumes` para remover os serviços e volumes.

Nota: Para acessar um terminal execute `$ docker exec -it relabs-back bash`. Por ele você é capaz de popular o banco de dados com `$ ruby import_from_csv.rb` e verificar os testes com `$ rspec`.

## Documentação da API

```shell
GET /tests
```

Retorna um JSON com lista de todos os exames cadastrados

```json
[
  {
    "result_token": "IQCZ17",
    "result_date": "2021-08-05",
    "patient": {
      "cpf": "048.973.170-88",
      "city": "Ituverava",
      "name": "Emilly Batista Neto",
      "email": "gerald.crona@ebert-quigley.com",
      "state": "Alagoas",
      "address": "165 Rua Rafaela",
      "birthdate": "2001-03-11"
    },
    "doctor": {
      "crm": "B000BJ20J4",
      "name": "Maria Luiza Pires",
      "email": "denna@wisozk.biz",
      "crm_state": "PI"
    },
    "tests": [
      {
        "type": "hemácias",
        "type_limits": "45-52",
        "type_results": "97"
      },
      {
        "type": "leucócitos",
        "type_limits": "9-61",
        "type_results": "89"
      }
    ]  
  }
]
```

