# Worker Shifts

## Setup Dependecies

* ruby 2.6.10
* rails 6.1.7
* postgresql

#### Install RVM
Install the right ruby version (currently 2.6.10):
```shell
  rvm install "ruby-2.6.10"
```

#### Check your Ruby version

```shell
  ruby -v
```

#### Install Database(postgresql)

```shell
  brew install postgresql
  brew services start postgresql
```

## Run Setup
* bundle install
* rails db:create
* rails db:schema:load or rails db:migrate

### Terminal Structure

* Tab 1: Github
* Tab 2: Rails Console (rails c)
* Tab 3: Rails Server (rails s)
