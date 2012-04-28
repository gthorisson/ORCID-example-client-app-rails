class RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_user!, :only => [:register_orcid]

  def new
    # If available, pull user's E-mail address out of the OAuth hash and pass
    # into registration form.
    
    build_params = {}
    begin
      build_params[:email] = session["omniauth"]["user_info"]["email"]
    rescue
      config.logger.debug "couldn't retrieve email from oauth hash: #{$!}"
    end
    user = build_resource(build_params)
    respond_with_navigational(user){ render :new }    
  end


  def create
    build_resource
    
    if resource.save
      set_flash_message :notice, :signed_up
      config.logger.debug 'created user, now signing in'
      #sign_in_and_redirect(resource_name, resource) # From Devise
      #sign_in_and_redirect(resource) # From Devise
      sign_in resource
      config.logger.debug 'User is signed in, redirecting to profile form'
      redirect_to new_profile_path, :notice => "Welcome, your are now registered. Do you want to enter additional profile information now?"
    else
      clean_up_passwords(resource)
      render :new
    end
  end
 
  # ?? move all the orcid reg. logic into its own separate controller ??
  def register_orcid

    # If user pushed 'no thanks' button
    ## forward to destination URL
    if params[:cancel]
      flash[:notice] = "Thank you. We will not ask you this again."
      # ToDo: need bool flag in user model to hold this
      if params[:destination]
        redirect_to params[:destination]
      else
        redirect_to root_url
      end
    end
    
    # otherwise render the default template which presents the first stage of the process
    render
  end

  def import_orcid_profile

    # based on info retrieved in the OAuth handshake, fetch the profile URL as RDF

    # Extract key properties from RDF and populate a hash
    ## private method for this 

    # Display to user for reviewing & confirmation

    # OR, if user has already confirmed the info, update the user record with data from VIVO
    
    # finally send user on to org. destination if there is one
    
  end
  
  #################### 
  private
    
  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
    end
  end
  
end
