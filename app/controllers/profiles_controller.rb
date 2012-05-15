# Controller for handling profile management and display

class ProfilesController < ApplicationController

  include OrcidProfileHelper

  
  # Only allow a logged-in users to create & update their profiles
  before_filter :authenticate_user!, :only => [:new,:show, :create, :update,:edit, :destroy]

  # Only allow access to public + protected profile  data via OAuth
  before_filter :oauth_required, :only => [:show_cidprofile_full]

  
  def new
    puts "Creating new profile for user " + current_user.email
    if profile = current_user.profile
      redirect_to profile_path, :notice => 'You already have a profile!' and return     
    end
    
    profile_data = {}
    
    # User may have elected to pull in profile info from an external source. If this is the case
    # we'll have some omniauth info in the session
    if session[:omniauth]
    #if session[:omniauth] && session[:params] && session[:params][:retrieve_external]
      
      orcid = session[:omniauth]['uid']
      
      Rails.logger.debug "Got some OAuth credential info from omniauth: " + session[:omniauth]['credentials'].inspect
      profile_data = retrieve_orcid_bio(orcid, session[:omniauth]['credentials']['token'])
      Rails.logger.debug "Profile data from external system: " + profile_data.inspect
      
      flash[:notice] = "Retrieved external profile data for ORCID #{session[:omniauth]['uid']}, please review"
    end    
    
    @profile = Profile.new(profile_data)
  
  end

  def create
    
    @profile = current_user.build_profile(params[:profile])

    if session[:omniauth]
      # Link up the profile with with the source external authn
      authn = Authentication.find_by_provider_and_uid(session[:omniauth]['provider'], session[:omniauth]['uid'])
      @profile.authentication = authn
      session[:omniauth] = nil # clear the omniauth stuff from the session, just in case
    end

    if @profile.save
      puts 'created new profile for user ' + current_user.email
      redirect_to profile_path, :notice => 'Profile was successfully created.'
    else
      render "new"
    end        
  end

  # Show complete profile only to the user who owns it
  def show
    @profile = current_user.profile

    # ToDo: error message if no profile is found for user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml  => @profile }
      format.json  { render :json => @profile }
    end    
  end

  def edit
    @profile = current_user.profile
  end


  def update
    @profile = current_user.profile
    puts 'Got profile to update='
    pp @profile
    puts "params="
    pp params

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(profile_path, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @profile = current_user.profile
    @profile.destroy    
    flash[:notice] = "Successfully destroyed profile."
    redirect_to account_url
  end


  private
  
  # Fix cryptic issue resulting in NoMethodError ("undefined method `current_user='" [..]
  def current_user=(user)
    sign_in(user)
  end
  
end

