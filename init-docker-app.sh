#!/bin/bash

bundle exec rake db:migrate:reset
bundle exec rspec --format RspecJunitFormatter --out tmp/rspec.xml
