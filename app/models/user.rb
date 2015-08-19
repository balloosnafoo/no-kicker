class User < ActiveRecord::Base
  validates :username, :email, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many(
    :teams,
    class_name: "Team",
    foreign_key: :manager_id,
    primary_key: :id
  )

  has_many :leagues, through: :teams, source: :league

  has_many(
    :commissioned_leagues,
    class_name: "League",
    foreign_key: :commissioner_id,
    primary_key: :id
  )

  has_many(
    :authored_messages,
    class_name: "Message",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id
  )

  ##### Auth stuff #####

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    if user && user.is_password?(password)
      user
    else
      flash[:errors] = ["Invalid credentials"]
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_session_token
    save!
    self.session_token
  end

  ##### League Stuff #####

  def team_in_league(id)
    teams.where(teams: { league_id: id })[0]
  end

  # Not in use currently
  def players_in_league(id)
    # Ryan: requires pre-fetching teams => players
    teams = self.teams.where(teams: { league_id: id }).includes(:players)
    teams[0].players
  end

  private
  def ensure_session_token
    self.session_token ||= generate_session_token
  end

  def generate_session_token
    SecureRandom.urlsafe_base64
  end
end
