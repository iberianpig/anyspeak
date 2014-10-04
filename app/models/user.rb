# Manage identification for user
class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.where(["provider = ? and uid = ?",
                       auth.provider, auth.uid]).first
    if user.blank?
      user = User.new(provider: auth.provider,
                      name:    auth.info.name,
                      uid:     auth.uid,
                      token:   auth.credentials.token)
      user.save!
    end
    user
  end

  def connectable?
    if connect_uid && updated_at >= Time.now.advance(seconds: -30)
      return true
    else
      return false
    end
  end
end
