# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

rails new rails_quiz
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zprofile
source ~/.zprofile
brew install rbenv
rbenv init
source ~/.bash_profile  # Or ~/.zshrc, depending on your shell
rbenv install 3.2.5
rbenv global 3.2.5
gem install rails -v 7.2.1

bin/rails s　でtailwindも起動できる
./bin/dev でtailwindが起動し監視

brew update
brew upgrade ruby
gem install bundler
bundle install
gem pristine --all

model作成
rails generate model Quizzes content:string image:string supplement:string
rails db:migrate
controller作成
rails generate controller Quizzes
seeder作成
rails generate seed Quizzes content:string image:string supplement:string
rails db:seed

rails db:reset

rails new . --skip-bundle --skip-git は既存プロジェクトに導入できる