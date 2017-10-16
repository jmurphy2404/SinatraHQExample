### Git setup below

$ mkdir HQ_headquarters

$ cd hq_headquarters

$ touch README.md app.rb Gemfile Rakefile

$ mkdir public views

$ mkdir public/css public/js

$ touch public/css/default.css

$ touch views/home.erb views/question.erb

$ touch public/js/main.js db/seeds.rb models.rb


```
### Gemfile below 

source 'http://rubygems.org'

gem 'sinatra'
gem 'sqlite3'
gem 'sinatra-activerecord'
gem 'rake'
```

### Rakefile

require 'sinatra/activerecord/rake'
require './app'

```
### Create db migration

#first command (create)
rake db:create_migration NAME=initial_schema

#second commands (migrate and load seed)
rake db:migrate
rake db:seed
```

### Define active record associations

User has many guesses
Guess belongs to a user

Question has many guesses
Guess Belongs to a question

* a user has many Questions (through Guesses)
* a