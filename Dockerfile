# Usa a imagem oficial mais recente do Ruby
FROM ruby:latest

# Define o diretório de trabalho no contêiner
WORKDIR /app

# Copia todo o conteúdo do diretório local para o diretório de trabalho no contêiner
COPY . ./

# Instala as dependências da aplicação
RUN gem install bundler && bundle install

# Define o comando padrão para iniciar a aplicação
CMD ["ruby", "server.rb"]
