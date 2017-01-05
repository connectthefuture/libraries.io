module LoginHelpers
  def mock_is_admin(admin = true)
    allow_any_instance_of(User).to receive(:admin?).and_return(admin)
  end

  def mock_github_auth(user)
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
      provider:    'github',
      uid:         user.uid,
      info:        {
        nickname: user.nickname,
        email:    user.email
      },
      credentials: {
        token: user.token
      }
    )
  end

  def login(user)
    mock_github_auth(user)
    visit '/auth/github'
  end
end

RSpec.configure do |config|
  config.include LoginHelpers
end
