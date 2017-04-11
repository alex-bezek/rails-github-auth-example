class User < ApplicationRecord

  validates :user_name, :provider, :uid, presence: true
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.avatar_url = auth.info.image
      user.user_name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.save! if user.changed?
    end
  end
end
