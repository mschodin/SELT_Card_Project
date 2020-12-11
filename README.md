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

### Commands to run in development
1. When working with JavaScript we are using yarn to install our packages. Install Yarn with: 
`curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -`\
`echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list`\
`sudo apt update && sudo apt install yarn`
2. To add frontend js libraries use:
`yarn add <library-name>`
3. To install all gems and npm libraries specified in gem file and package.json use:
`yarn install`\
`bundle install`
4. Install redis
`sudo apt install redis-server`
 then run a redis server to control the cables
`redis-server`
5. Commands to run the server:
 * Run the server: `bundle exec rails server`
 * To see JS changes automatically get packed by webpack run: `./bin/webpack-dev-server`
