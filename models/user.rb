# models/user.rb
class User
  attr_accessor :id, :username, :email

  def initialize(id, username, email)
    @id = id
    @username = username
    @email = email
  end

  def self.find(user_id)
    # Mocking a user retrieval. Replace this with actual database logic.
    User.new(user_id, "JaneDoe", "jane.doe@example.com")
  end
end
