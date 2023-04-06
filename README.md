# ZSSN (Zombie Survival Social Network)

Esta aplicacão tem como maior objetivo explorar conhecimentos para o desafio de criação de uma API em Ruby on Rails para controle de usuários, atendendo alguns tópicos:

    - Cadastro de usuários.
    - Atualizar localização de usuário.
    - Adicionar e remover items do usuário.
    - Marcar usuário como infectado.
    - Escambo de items.
    - Relatórios: 
        Porcentagem de usuários infectados; 
        Porcentagem de usuários não-infectados;
        Quantidade média de cada tipo de item por usuário (águas/usuário, comidas/usuário, etc);
        Número de pontos perdidos por usuários infectados.

Topics:

- Stack
- Pontapé inicial
- Construindo o container
- Criação do banco
- Executando os testes com Rspec
- Checando a cobertura de testes da aplicacão
- Executando o rubocop como lint de código
- Executando a aplicação em um docker
- Parar a execução do docker com a aplicação
- Créditos

## Stack

- Docker/Docker-compose (https://docs.docker.com/get-docker/) - Criação de container para desenvolvimento

## Pontapé inicial

*** Antes de começar, certifique-se que o arquivo database.yml esteja configurado corretamento, é importante que a chave "host" esteja definido com o nome do serviço no container_name (postgres_db) do docker-compose.yml ***

## Construindo o container 

Para fazer build da imagem do container, basta executar o seguinte comando na raiz da aplicação:

```bash
docker-compose build
```

## Criação do banco

Para fazer build da imagem do container, basta executar o seguinte comando na raiz da aplicação:
```bash
docker-compose run --rm api bundler exec rails db:create 
docker-compose run --rm api bundler exec rails db:migrate
```

## Executando os testes com Rspec

Para executar os testes com o Rspec, basta executar o seguinte comando na raiz da aplicação:

```bash
docker-compose run --rm api bundler exec rspec
```

## Checando a cobertura de testes da aplicacão

Após executar os testes pelo rspec, um arquivos é criado na pasta 'coverage/index.html', para abrir, execute o comando:

```bash
 open coverage/index.html
```

## Executando o rubocop como lint de código

Para checar alguma inconformidade de lint de código, basta executar o rubocop:

```bash
docker-compose run --rm --no-deps api bundler exec rubocop
```

## Executando a aplicação em um docker

Para executar a aplicação no docker, execute:

```bash
docker-compose up
```

Agora voce deve ter um container executando, para verificar execute o seguinte comando:

```bash
docker ps
```

A api estará exposta na url (http://localhost:3000/)

## Remover os containers

Para remover o container caso necessário, execute o comando:

```bash
docker-compose down
```

## Créditos

*Flavio Avila*<br>
flavio.avila.silva@outlook.com<br>
https://github.com/flavioavilasilva<br>
https://www.linkedin.com/in/flavio-avila-7775702b/
