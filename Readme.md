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
Isso inicia os contêineres do banco de dados e servidor em rede. <br>
Endereço padrão: http://localhost:3000/.

3. Para encerrar: <br>
Pressione Ctrl + C no terminal onde o Docker Compose está em execução. <br>
Em seguida, execute `$ docker-compose down` para remover os contêineres.

Nota: Para acessar um terminal execute `$ docker exec -it relabs-back bash`.

## Documentação da API

```shell
GET /tests <br>
```

Retorna um JSON com listagem de todos os exames cadastrados

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
        "test_type": "hemácias",
        "test_type_limits": "45-52",
        "test_type_results": "97"
      },
      {
        "test_type": "leucócitos",
        "test_type_limits": "9-61",
        "test_type_results": "89"
      }
    ]  
  }
]
```

