# Waves #

A MongoDB and Ruby on Rails powered application for running a tumblelog.

This is the successor to my other venture into the tumbleverse in the form of
[theorangeseed][theorangeseed].

## Getting it up & Running ##

You must have [MongoDB][mongodb] installed.

1. Edit MongoDB configuration details in `config/initializers/mongodb.rb`
2. Create `config/initializers/email_settings.rb` and put your
   `smtp_settings` and `default_url_options` in it.
3. Create `config/initializers/secret_token.rb` and put
   `Waves::Application.config.secret_token = 'your-secret-token'` in it. A
   token can be generated with `rake secret`.
3. Run `bundle install`
4. Run `rails server` and it should be good to go

Create an account either through the console or with `rake db:seed`.

## To Dos ##

* Archives
* Template system (like Liquid)
* Improve Atom feed
* Admin panel and/or more administration features


[theorangeseed]: http://github.com/matharvard/theorangeseed
[mongodb]: http://www.mongodb.org/
