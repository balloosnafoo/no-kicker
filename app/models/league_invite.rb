class LeagueInvite < ActiveRecord::Base
  validates :league_id, presence: true
  validate :has_email_or_username
  validate :username_exists

  belongs_to :league

  def user
    @user = User.find_by_email(email)
    return @user if @user

    @user = User.find_by_username(username)
    @user if @user
  end

  private
  def has_email_or_username
    unless username || email
      errors[:league_invite] << "must have a username or email"
    end
  end

  def username_exists
    if username && !User.find_by_username(username)
      errors[:league_invite] << "must refer to an actual username"
    end
  end
end
