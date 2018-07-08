class User
  attr_reader :id, :name

  def initialize(id, username, name, email, password)
    @id = id
    @username = username
    @name = name
    @email = email
    @password = password
  end

  def self.create(username, name, email, password)
    result = DatabaseConnection.query("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password}') RETURNING id, username, name, email, password;")
    User.new(result.first['id'], result.first['username'], result.first['name'], result.first['email'], result.first['password'])
  end

  def self.find(id)
    return nil unless id
    result = DatabaseConnection.query("SELECT * FROM users WHERE id = '#{id}'")
    User.new(result.first['id'], result.first['username'], result.first['name'], result.first['email'], result.first['password'])
  end
end
