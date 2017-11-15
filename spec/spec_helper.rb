ENV['RACK_ENV'] = 'test'

require './models/link'
require './app/app.rb'
require 'capybara'
require 'capybara/rspec'
require 'database_cleaner'
require 'rspec'
require 'data_mapper'
require 'dm-migrations'
require 'dm-postgres-adapter'
require './spec/features/web_helpers.rb'


Capybara.app = Bookmark

RSpec.configure do |config|
  require 'data_mapper'
  #DataMapper.setup(:default, ENV[''] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}") # this suggested by heroku setup


  DataMapper.setup(:default, 'postgres://localhost/bookmark_manager_test')
  DataMapper.finalize
  Link.auto_upgrade!


    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:transaction)
    end

    config.around(:each) do |eg|
      DatabaseCleaner.cleaning do
        eg.run
      end
    end
end
