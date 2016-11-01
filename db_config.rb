require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'ballpark'
}

ActiveRecord::Base.establish_connection(options)
