require 'pry'
require 'sqlite3'

db = SQLite3::Database.new 'test.db'

require 'active_model'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: 'test.db'
)

require 'active-ingredients'
require 'fixtures/phone'
require 'fixtures/account'
require 'fixtures/physical_address'
require 'fixtures/location'


RSpec.configure do |config|
  config.before(:suite) do
    # Create schema
    Account.connection.execute 'drop table if exists accounts;'
    Account.connection.execute <<-SQL
      create table accounts (
        id           int,
        home_phone   varchar(30),
        mobile_phone varchar(30)
      );
    SQL

    Location.connection.execute 'drop table if exists locations;'
    Location.connection.execute <<-SQL
      create table locations (
        id       int,
        address1 varchar(255),
        address2 varchar(255),
        city     varchar(255),
        zipcode  varchar(63),
        country  varchar(63),
        phone_number varchar(30)
      );
    SQL
  end
end
