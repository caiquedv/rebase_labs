# Listagem de exames

## Tecnologias 
- Sinatra
- Puma
- RSpec
- Postgres

## Para rodar 
### 1. Clone e acesse o projeto

### 2. Suba o container contendo o banco de dados
`$ docker run --rm --name relabs-db -v ./db:/var/lib/postgresql/data -e POSTGRES_PASSWORD=password --network relabs-network -p 5432:5432 postgres`

### 3. Suba o container contendo o servidor
`$ docker run --rm --name relabs-server -w /app -v .:/app --network relabs-network -p 3000:3000 ruby bash -c 'bundle install && ruby server.rb'`

Acesse a [listagem](http://localhost:3000/tests)
