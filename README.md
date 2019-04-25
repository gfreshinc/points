# Gfresh Point

## Install

`gem 'gfresh_point'`

## Initialize

run `bundle exec rails generate gfresh_point:install`

In `config/initializers/gfresh_point.rb` file

```ruby
require "gfresh_point"
$gfresh_point = GfreshPoint::Client.new('your_app_id')
```
