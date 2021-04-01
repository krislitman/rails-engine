# Rails Engine

Rails Engine is a Rails API Application, with data exposed through an API.

## Table of Contents

  - [Authors](#authors)
  - [Getting Started](#getting-started)
  - [Runing the tests](#running-the-tests)
  - [Built With](#built-with)
  - [Versioning](#versioning)

## Author

  - **Kris Litman** -
    [Kris' GitHub](https://github.com/krislitman)
    [Kris' LinkedIn](https://www.linkedin.com/in/kris-litman-7095351a4/)

## Getting Started

### Installing

These instructions will get you a copy of the project up and running on
your local machine for development and testing purposes. See deployment
for notes on how to deploy the project on a live system.

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Download data: https://raw.githubusercontent.com/turingschool/backend-curriculum-site/gh-pages/module3/projects/rails_engine/rails-engine-development.pgdump
4. Run rails db:{drop,create,migrate,seed} -- (you may see errors from pg_restore that you can ignore)

## Overview

### Database Schema

There are six different tables:
<ul>
  <li>Items</li>
  <li>Merchants</li>
  <li>Orders</li>
  <li>Order-Items</li>
  <li>Invoices</li>
  <li>Transactions</li>
  </ul>

## Running the tests

Run **bundle exec rspec** to run the test suite.

## Built With

- Ruby
- Rails
- RSpec
- Factory Bot
- Faker

## Versions

- Ruby 2.5.3

- Rails 5.2.5
