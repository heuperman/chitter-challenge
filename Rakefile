require 'pg'

if ENV['RACK_ENV'] != 'production'
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new :spec

  task default: [:spec]
end

task :test_database_setup do
  p "Cleaning databases"

  connection = PG.connect(dbname: 'blabber_test')
  connection.exec("TRUNCATE blabs, users;")
end

task :setup do
  p "Creating databases"

  ['blabber', 'blabber_test'].each do |database|
    connection = PG.connect
    connection.exec("CREATE DATABASE #{database};")

    connection = PG.connect(dbname: database)
    connection.exec("CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      username VARCHAR(60),
      name VARCHAR(60),
      email VARCHAR(60),
      password VARCHAR(240)
      );")
    connection.exec("CREATE TABLE blabs (
      id SERIAL PRIMARY KEY,
      timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      content VARCHAR(128),
      user_id INTEGER REFERENCES users (id)
      );")
  end
end

task :teardown do
  p "Destroying databases...type 'y' to confirm that you want to destroy the"\
" Bookmark Manager databases. This will remove all data in those databases!"

  confirm = STDIN.gets.chomp

  return unless confirm == 'y'

  ['blabber', 'blabber_test'].each do |database|
    connection = PG.connect
    connection.exec("DROP DATABASE #{database}")
  end
end
