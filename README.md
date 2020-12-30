# rfresh

Rails fresh template: clean and secure.

## What's inside
* rubocop - a Ruby static code analyzer https://github.com/rubocop-hq/rubocop
* rspec, faker, factory_bot, shoulda-matchers, simplecov, fuubar - RSpec tests tooliong https://rspec.info
* bundle-audit - patch-level verification for bundler https://github.com/rubysec/bundler-audit
* brakeman - a static analysis tool which checks Ruby on Rails applications for security vulnerabilities https://github.com/presidentbeef/brakeman
* annotate - summarizing the current model's schema https://github.com/ctran/annotate_models
* letter_opener - preview email in the default browser instead of sending it https://github.com/ryanb/letter_opener 
* awesome_print - a Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation https://github.com/awesome-print/awesome_print
* ordinare - sorts gems in your Gemfile alphabetically https://github.com/nikolalsvk/ordinare
* foreman - manage Procfile-based applications https://github.com/ddollar/foreman
* slim-rails - Slim lang generators for Rails https://github.com/slim-template/slim-rails
* github/actions CI for Rails, Ruby 3.0.0, PostgreSQL app

## How to use

To create a new application, you can use a template with any 
standard parameters.

```bash
rails new myApp -m https://github.com/mpakus/rfresh/main/template.rb
```
or with parameters like:
```bash
rails new myApp -m https://github.com/mpakus/rfresh/main/template.rb -d postgresql -T --skip-action-mailbox -skip-active-storage 
```
etc.

To apply a template to an existing application:
```bash
rails app:template LOCATION=https://github.com/mpakus/rfresh/main/template.rb
```
