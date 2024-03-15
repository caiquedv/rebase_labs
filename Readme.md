# Rebase Labs
Uma app web para listagem de exames médicos.

## Tecnologias 
- Sinatra
- Puma
- Postgres

## Pré-requisitos
- Docker

## Para Executar 
1. Clone o repositório e acesse o projeto. <br>
`$ git clone git@github.com:caiquedv/rebase_labs.git && cd rebase_labs`

2. Execute `$ docker-compose up` para iniciar a aplicação. <br>
Isso inicia os serviços da aplicação. <br>
URL base da API: http://localhost:3000 <br>
URL do Front-End: http://localhost:2000

3. Para encerrar: <br>
Pressione Ctrl + C no terminal onde o Docker Compose está em execução. <br>
(Opcional) Execute `$ docker-compose down --volumes` para remover os serviços e volumes.

## Popular Banco de dados
Para inserir dados de exames fake, execute na raíz do projeto <br> 
`$ docker exec relabs-back ruby import_from_csv.rb`

## Testes
Para testar o Back-End execute `$ docker exec relabs-back rspec` <br>
Para testar o Front-End execute `$ docker exec relabs-front rspec` <br>

## Abrir um terminal
Para o back execute `$ docker exec -it relabs-back bash` <br>
Para o front execute `$ docker exec -it relabs-front bash`

## Banco de dados
Existe um banco de dados 'development' onde são inseridos os dados da interação com a app, como popular o banco de dados ou fazer o upload de um arquivo csv. Também há um banco de dados 'test' dedicado aos testes. As tabelas são limpas ao fim de cada teste. <br>
Confira o script de criação do banco de dados no arquivo back/init.sql.

### Resetar o banco de dados
Para remover todos os registros execute `$ docker-compose down --volumes` e remova a pasta do banco de dados com `$ sudo rm -rf back/db`.

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
        "limits": "45-52",
        "results": "97"
      },
      {
        "type": "leucócitos",
        "limits": "9-61",
        "results": "89"
      }
    ]  
  },
  {
    "exam_result_token": "0W9I67",
    "exam_result_date": "2021-07-09",
    "patient": {
      "patient_cpf": "048.108.026-04",
      "patient_name": "Juliana dos Reis Filho",
      "patient_email": "mariana_crist@kutch-torp.com",
      "patient_birthdate": "1995-07-03",
      "patient_address": "527 Rodovia Júlio",
      "patient_city": "Lagoa da Canoa",
      "patient_state": "Paraíba"
    },
    "doctor": {
      "doctor_crm": "B0002IQM66",
      "doctor_crm_state": "SC",
      "doctor_name": "Maria Helena Ramalho",
      "doctor_email": "rayford@kemmer-kunze.info"
    },
    "tests": [
      {
        "test_type": "hemácias",
        "test_type_limits": "45-52",
        "test_type_results": "28"
      },
      {
        "test_type": "leucócitos",
        "test_type_limits": "9-61",
        "test_type_results": "91"
      },
      {
        "test_type": "plaquetas",
        "test_type_limits": "11-93",
        "test_type_results": "18"
      },
      {
        "test_type": "hdl",
        "test_type_limits": "19-75",
        "test_type_results": "74"
      }
    ]
  }
]
```

```shell
GET /tests/:token
```

Retorna um JSON com um registro específico por token. <br>
Por exemplo:

```shell
GET /tests/IQCZ17
```

```json
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
      "limits": "45-52",
      "results": "97"
    },
    {
      "type": "leucócitos",
      "limits": "9-61",
      "results": "89"
    }
  ]  
}
```

```shell
POST /import
```
Realiza o upload de um arquivo csv de forma assíncrona.

```
curl -X POST -H "Content-Type: multipart/form-data" \
     -F "file=@back/spec/support/small_data.csv;type=text/csv" \
     http://localhost:3000/import
```
Em caso de sucesso retorna:
```
{ done: 'Your document has been enqueued to import' }
```

## Tela do Front-End
Caso tenha populado o banco de dados, ao acessar a url http://localhost:2000 verá uma listagem com todos os exames da base de dados, caso contrário somente o cabeçalho será exibido.

[![tests-list.png](https://i.postimg.cc/t7QTBrN1/tests-list.png)](https://postimg.cc/5Qgb0SG1)

É possível pesquisar por um exame específico pelo token. Volte para a listagem clicando no botão 'Back to list'.

[![test-token.png](https://i.postimg.cc/MGmfL8ny/test-token.png)](https://postimg.cc/7CbLCdM6)

Caso pesquise sem inserir um token verá um aviso pedindo para inserir.

[![no-token.png](https://i.postimg.cc/ZqzV33BV/no-token.png)](https://postimg.cc/TKQVvKcD)

Faça o upload de um arquivo .csv clicando em 'Import CSV file' e em seguida clique em 'Upload'.

[![upload-data.png](https://i.postimg.cc/sDSjKdHK/upload-data.png)](https://postimg.cc/rKV2Fbkt)

O arquivo será enfileirado e em seguida importado para o banco de dados.

[![succes-upload.png](https://i.postimg.cc/909DG4qY/succes-upload.png)](https://postimg.cc/8f1kGz47)

Caso faça o upload sem selecionar um arquivo verá o aviso pedindo para selecionar.

[![no-upload.png](https://i.postimg.cc/3JgPqKXS/no-upload.png)](https://postimg.cc/8jzKJgnM)