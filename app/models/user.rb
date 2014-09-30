class User < ActiveRecord::Base
  def self.find_or_create_by_auth(auth)
    user = User.where(["provider = ? and uid = ?", auth.provider, auth.uid]).first
    if user.blank?
      user = User.new
      user.provider = auth.provider
      user.uid = auth.uid
      user.token = auth.credentials.token
      user.save!
    end
    user
  end
end
