class User < ActiveRecord::Base
  validates :username, :emai, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_null: true }

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user.is_password(password)
      login!(user)
      user
    else
      flash[:errors] = ["Invalid credentials"]
    end
  end

  def password=(password)
    @password = password
    self.password = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    save
    session_token
  end

  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
