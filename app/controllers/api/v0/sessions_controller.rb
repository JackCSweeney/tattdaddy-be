class Api::V0::SessionsController < ApplicationController

  def create 
    auth_hash = request.env['omniauth.auth']
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params[:code]

    # Exchange the code for an access token
    conn = Faraday.new(url: 'https://github.com/login/oauth/authorize', headers: {'Accept': 'application/json'})
    response = conn.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
    end  

    data = JSON.parse(response.body, symbolize_names: true)
    access_token = data[:access_token]

    # Fetch user data using the access token
    conn = Faraday.new(
    url: 'https://api.github.com',
    headers: {
        'Authorization': "token #{access_token}"
      }
    )
    response = conn.get('/user')
    data = JSON.parse(response.body, symbolize_names: true)
    
    if user = User.find_by(uid: data[:id])
      jwt_token = JWT.encode({attributes: { user_id: user.id, uid: user.uid, email: user.email, name: user.name, location: user.location }}, ENV['JWT_SECRET'], 'HS256')
      redirect_to "http://localhost:5000/auth/github/callback?token=#{jwt_token}"
    else
      user = User.new( {uid: data[:id], name: data[:name], location: data[:location].presence || "Unknown", email: data[:email].presence || "Unknown"})
      user.token = access_token
      user.password = access_token
      user.save!
      jwt_token = JWT.encode({ user_id: user.id, uid: user.uid, email: user.email, name: user.name, location: user.location }, ENV['JWT_SECRET'], 'HS256')
      redirect_to "http://localhost:5000/auth/github/callback?token=#{jwt_token}"
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :location, :email, :search_radius, :password)
  end
  # def google_oauth2
  #   # Redirect to Google's authorization URL
  #   require 'pry'; binding.pry
  #   redirect_to "/auth/google_oauth2/callback"
  # end

  # def google_oauth2_callback
  #   # Handle callback from Google OAuth
  #   auth_hash = request.env['omniauth.auth']
  #   require 'pry'; binding.pry
  #   # Your logic to handle authentication and user creation/update based on auth_hash
    
  #   # Redirect to appropriate page after successful authentication
  #   redirect_to root_path
  # end
end 