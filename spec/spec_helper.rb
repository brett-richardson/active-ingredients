require 'pry'
require 'sqlite3'

db = SQLite3::Database.new 'test.db'

require 'active_model'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: 'test.db'
)

require 'active_ingredients'
require 'fixtures/phone'
require 'fixtures/account'

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
  end
end
