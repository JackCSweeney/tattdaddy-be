class Api::V0::SessionsController < ApplicationController

  def create 
    auth_hash = request.env['omniauth.auth']
    client_id = ENV['GITHUB_CLIENT_ID']
    client_secret = ENV['GITHUB_CLIENT_SECRET']
    code = params[:code]
    # redirect_uri = "http://localhost:5000/auth/github/callback"
    # require 'pry'; binding.pry
    # Exchange the code for an access token
    conn = Faraday.new(url: 'https://github.com/login/oauth/authorize', headers: {'Accept': 'application/json'})
    response = conn.post('/login/oauth/access_token') do |req|
      req.params['code'] = code
      req.params['client_id'] = client_id
      req.params['client_secret'] = client_secret
      # req.params['redirect_uri'] = redirect_uri
    end  
    # require 'pry'; binding.pry
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
    
    # require 'pry'; binding.pry
    # Create or update the user in your database
    user = User.new( {uid: data[:id], name: data[:name], location: data[:location].presence || "Unknown", email: data[:email].presence || "Unknown"})
    user.name = data[:name]
    user.email = data[:email]
    user.location = data[:location]
    user.uid = data[:id]
    user.token = access_token
    user.save!(validate: false)
    # require 'pry'; binding.pry
    # redirect_to "http://localhost:5000/auth/github/callback?token=#{user.token}&user=#{user}"
    # Generate JWT token with user data
    jwt_token = JWT.encode({ user_id: user.id, uid: user.uid, name: user.email }, ENV['JWT_SECRET'], 'HS256')
    redirect_to "http://localhost:5000/auth/github/callback?token=#{jwt_token}"
      require 'pry'; binding.pry
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