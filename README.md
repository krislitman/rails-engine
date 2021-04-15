# Rails Engine

Rails Engine is a Rails API Application, created with Ruby on Rails

## Table of Contents

  - [Author](#author)
  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versioning)

## Author

  - **Kris Litman**<br>
    [GitHub](https://github.com/krislitman)<br>
    [LinkedIn](https://www.linkedin.com/in/kris-litman-7095351a4/)

## Getting Started

### Installing

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Download data: https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump
4. Run rails db:{drop,create,migrate,seed} -- (you may see errors from pg_restore that you can ignore)
5. Run rails s to start the rails server, and to see json responses

## Overview

### Database Schema

There are six different tables:
<ul>
  <li>Items</li>
  <li>Merchants</li>
  <li>Invoice Items</li>
  <li>Customers</li>
  <li>Invoices</li>
  <li>Transactions</li>
  </ul>
  
### Endpoints

Run **localhost:3000**

GET all merchants `http://localhost:3000/api/v1/merchants`
OPTIONAL query parameters: 
`per_page` Integer value of how many merchants to return. Defaults to 20 if not given.
`page` Integer value of a 'page' of resources to skip before returning data, defaults to 1 if not given.

GET show a single merchant `http://localhost:3000/api/v1/merchants/:id`

POST create an item `localhost:3000/api/v1/items` with JSON body

UPDATE an item `localhost:3000/api/v1/items/:id` with JSON body

DESTROY an item `localhost:3000/api/v1/items/:id` also destroys corresponding invoice if only item on that invoice

GET merchant items `http://localhost:3000/api/v1/merchants/:id/items`

GET items merchant `http://localhost:3000/api/v1/items/:id/merchant`

GET find all items `http://localhost:3000/api/v1/items/find_all`
OPTIONAL query parameters:
`name` to search for items by name or name fragment
`min_price` should look for anything with this price or greater
`max price` should look for any item with this price or less
both `min_price` and `max_price` can be sent, but not all three

GET find one merchant `http://localhost:3000/api/v1/merchants/find`

GET merchants by total revenue `http://localhost:3000//api/v1/revenue/merchants`
REQUIRED query parameter:
`quantity` to limit the number of merchants returned

GET merchants with most items sold `http://localhost:3000//api/v1/merchants/most_items`
REQUIRED query parameter:
`quantity` to limit the number of merchants returned

GET total revenue for a merchant `http://localhost:3000//api/v1/revenue/merchants/:id`

GET potential revenue of unshipped orders by revenue `http://localhost:3000//api/v1/revenue/unshipped`
OPTIONAL query parameter:
`quantity` to limit the number of orders to return, defaults to 10 if not given

## Running the tests

You will need Factory Bot set up to run the test suite. Please visit this link for gem instructions: [Factory Bot Rails](https://github.com/thoughtbot/factory_bot_rails). Run **bundle exec rspec** to run the test suite. 

## Built With

- Ruby on Rails
- PostgreSQL
- RSpec
- Capybara
- Fast JsonAPI
- Factory Bot
- Faker
- Rubocop
- Simplecov
- Git Workflow

## Versions

- Ruby 2.5.3

- Rails 5.2.5
