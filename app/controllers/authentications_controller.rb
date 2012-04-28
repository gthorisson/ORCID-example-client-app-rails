class AuthenticationsController < ApplicationController

  def index
    @authentications = current_user.authentications if current_user    
  end

  def create
    puts request.env["omniauth.auth"].to_yaml
    omniauth = request.env["omniauth.auth"] 

    # Try to find an existing user already authenticated with this provider
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])  
    if authentication
      flash[:notice] = "Signed in successfully via #{omniauth['provider'].titleize}"
      sign_in_and_redirect(:user, authentication.user)  

    # Otherwise create a new authentication for the currently signed-in user  
    elsif current_user
      current_user.authentications.create(:provider       => omniauth['provider'],
                                          :uid            => omniauth['uid'],
                                          :profile_uri    => omniauth['extra']['raw_info']['profile_uri'],
                                          :profile_format => omniauth['extra']['raw_info']['profile_format'])
      flash[:notice] = "Authentication successful. Your #{omniauth['provider'].camelize} ID #{omniauth['uid']} has been linked to your user account" 
      redirect_to account_url  

    # or else create a brand new user from scratch
    else
      user = User.new  
      user.apply_omniauth(omniauth)

      if user.save  
        flash[:notice] = "Registered & signed in successfully via #{omniauth['provider'].titleize}"
        # add link to destination to flash notice
        sign_in_and_redirect(:user, user)
      else  
        session[:omniauth] = omniauth.except('extra')  
        redirect_to new_user_registration_url  
      end  
    end
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to account_url
  end
end
