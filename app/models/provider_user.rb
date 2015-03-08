class ProviderUser
  attr_accessor :auth
  delegate :provider, :uid, :info, :credentials, to: :auth, allow_nil: true
  delegate :email, :first_name, :last_name, :image, to: :info, allow_nil: true
  delegate :token, to: :credentials, allow_nil: true

  def initialize(auth)
    self.auth = auth
  end

  def create_or_update
    User.where(provider: provider, uid: uid).first_or_initialize.tap do |user|
      user.attributes = user_params
      user.save if user.changed?
    end
  end

  def user_params
    {
      email: email,
      name: "#{first_name} #{last_name}",
      image: image,
      token: token
    }
  end
end
