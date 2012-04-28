require 'faraday_stack'


class ProfilesController < ApplicationController

  # Handles profile management and display, including OAuth access to protected data
  
  # Only allow a logged-in users to create & update their profiles
  before_filter :authenticate_user!, :only => [:new,:show, :create, :update,:edit, :destroy]

  # Only allow access to public + protected profile  data via OAuth
  before_filter :oauth_required, :only => [:show_cidprofile_full]

  
  def new
    puts "Creating new profile for just-created + authn'd user " + current_user.email
    if profile = current_user.profile      
      redirect_to profile_path, :notice => 'You already have a profile!' and return     
    end
    
    profile_data = {}
    
    # User may have elected to pull in profile info from an external source
    if params[:retrieve_external_profiledata]
      @external_authn = Authentication.find(params[:external_authn_id])
      
      profile_data = retrieve_external_profile_data(@external_authn.profile_uri, @external_authn.profile_format)
      flash[:notice] = 'Retrieved external profile data from '+ @external_authn.provider + ", please review"
    end
    
    @profile = Profile.new(profile_data)
  
  end

  def create
    
    @profile = current_user.build_profile(params[:profile])

    # Generate ORCID identifier via built-in random no. generation utility & format
    #   -sample: 1422-4586-3573-0476
    cid = '%016d' % rand( 10000_0000_0000_0000-1 ) # Want 16-digit number
    cid.gsub!(/(\d{4})/,'\1-') # Make readable by clustering into groups of four digits
    cid.chop!
    puts 'generated nice-looking CID=' + cid
    @profile.cid = cid
    if @profile.save
      puts 'created new profile for user ' + current_user.email
      pp @profile
      #redirect_location_for(current_user, )
      # ToDo more sensible redirection behaviour here, after a user has created a profile
      redirect_to profile_path, :notice => 'Profile was successfully created.'
    else
      render "new"
    end        
  end

  # Show complete profile only to the user who owns it
  def show
    @profile = current_user.profile

    # ToDo: error message if no profile is found for user

    puts 'Got profile='
    pp @profile
    

    puts 'got other_names='
    pp @profile.other_names

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
  
  # Retrieve external profile data using the given URI in the given format
  def retrieve_external_profile_data(uri, format)

    # Via tip from object http://mislav.uniqpath.com/2011/07/faraday-advanced-http/
    conn = Faraday.new :url => uri do |builder|
      #builder.use Faraday::Response::Logger,     Logger.new('faraday.log')
      builder.use FaradayStack::FollowRedirects, limit: 3
      builder.use Faraday::Response::RaiseError # raise exceptions on 40x, 50x responses
      builder.use Faraday::Adapter::NetHttp
    end
    conn.headers[:accept] = format
    puts "Retrieving profile data from " + uri + " as " + format
    profile_response = conn.get uri
    puts 'raw profile data: ' + profile_response.body

    # For the moment we just want to handle a couple of main profile formats. No
    # attempt at this time to normalize into some standard representation.
    case format
      when "application/json"  # NB can add multiple conditions here, like text/json or whatever
        parse_profile_data_json profile_response.body
      when "text/turtle"
        parse_profile_data_rdf profile_response.body
      else
        # some useful error message here, or perhaps just return nil
    end
  end

  # Parase profile JSON and return as a hash
  def parse_profile_data_json(profile_string)
    profile_hash_org = MultiJson.decode(profile_string)
    Rails.logger.debug "Pulling fields out of org profile hash: " + profile_hash_org.inspect
    subhash = profile_hash_org['orcid.orcid-message']['orcid.orcid-profile']
    Rails.logger.debug subhash.inspect
    profile_hash = {
      :orcid     => subhash['orcid.orcid'],
      :firstname => subhash['orcid.orcid-bio']['orcid.personal-details']['orcid.given-names'],
      :lastname  => subhash['orcid.orcid-bio']['orcid.personal-details']['orcid.family-name'],
    }
    Rails.logger.debug "Final hash with profile data from JSON: " + profile_hash.inspect
    return profile_hash
  end


end

