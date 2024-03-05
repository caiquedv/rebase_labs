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

#### Usando Docker Compose
3. Execute `$ bin/dev` para iniciar a aplicação. <br>
Isso inicia os contêineres do banco de dados e servidor em rede.

4. Para encerrar: <br>
Pressione Ctrl + C no terminal onde o Docker Compose está em execução. <br>
Em seguida, execute `$ docker-compose down` para remover os contêineres.

#### Alternativa: Execução Manual
<sup> Nota: Caso tenha feito com Docker Composer é necessário antes remover os contêineres. </sup>

3. Crie a rede Docker caso ainda não tenha: <br>
`$ docker network create relabs-network`

4. Inicie o container com o banco de dados: <br>
```
$ docker run --rm --name relabs-db -v ./db:/var/lib/postgresql/data \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=lab \
    -e POSTGRES_USER=user \
    --network relabs-network -p 5432:5432 postgres
```

5. Inicie o container com o servidor: <br>
```
$ docker run --rm --name relabs-server -w /app -v .:/app \
    --network relabs-network -p 3000:3000 ruby bash \
    -c 'bundle install && ruby server.rb'
```

6. Para encerrar: <br>
Pressione Ctrl + C em ambos os terminais em execução. <br>

Teste a app online em http://localhost:3000/tests. <br>
Esse endpoint ativo significa que o servidor está online e conectado com o BD.
