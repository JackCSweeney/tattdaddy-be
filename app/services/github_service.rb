class GithubService

  def self.authenticate(code)
    find_or_create_user(code)
  end

  def self.conn_to_get_token
    Faraday.new(url: 'https://github.com', headers: {'Accept': 'application/json'})
  end

  def self.post_for_access_token(code)
    response = conn_to_get_token.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
    end
    JSON.parse(response.body, symbolize_names: true)[:access_token]
  end

  def self.conn_to_auth_token(code)
    token = post_for_access_token(code)
    Faraday.new(
      url: 'https://api.github.com',
      headers: {
        'Authorization': "token #{token}"
      }
    )
  end

  def self.get_token_auth(code)
    response = conn_to_auth_token(code).get('/user')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_or_create_user(code)
    data = get_token_auth(code)

    if User.find_by(uid: data[:id])
      user = User.find_by(uid: data[:id])
      jwt_token = JWT.encode({attributes: { user_id: user.id, uid: user.uid, email: user.email, name: user.name, location: user.location, search_radius: user.search_radius }}, ENV['JWT_SECRET'], 'HS256')
    else
      user = User.new( {uid: data[:id], name: data[:name], location: data[:location].presence || "Unknown", email: data[:email].presence || "Unknown"})
      user.token = access_token
      user.password = access_token
      user.save!
      jwt_token = JWT.encode({ user_id: user.id, uid: user.uid, email: user.email, name: user.name, location: user.location }, ENV['JWT_SECRET'], 'HS256') 
    end
  end
end