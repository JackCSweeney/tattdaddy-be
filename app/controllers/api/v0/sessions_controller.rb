class Api::V0::SessionsController < ApplicationController
  def google_oauth2
    # Redirect to Google's authorization URL
    redirect_to "/auth/google_oauth2/callback"
  end

  def google_oauth2_callback
    # Handle callback from Google OAuth
    auth_hash = request.env['omniauth.auth']
    
    # Your logic to handle authentication and user creation/update based on auth_hash
    
    # Redirect to appropriate page after successful authentication
    redirect_to root_path
  end
end 