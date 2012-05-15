# These helpers are useful for retrieving & manipulating ORCID profile data

require 'oauth2'
require 'multi_xml'

module OrcidProfileHelper

  # TODO move consumer ID + secret to a config file!!
  CLIENT = OAuth2::Client.new '8933-0264-7715-6870','1ae28805-be96-4899-891a-a00159625745', :site  => 'http://localhost:8080'
  
  # Prepare the OAuth token needed to make the Tier 2 API call
  def build_token(access_token)
    return OAuth2::AccessToken.new CLIENT, access_token
  end
  
  def retrieve_orcid_bio(orcid, access_token)
    
    Rails.logger.debug "Retrieving ORCID bio data for #{orcid} using access token #{access_token}"

    # Prepare and send the OAuth request with the single-use token
    response = build_token(access_token).get "/t2/#{orcid}/orcid-bio"
    Rails.logger.debug "response.body: " + response.body
    profile = MultiXml.parse(response.body)['orcid_message']['orcid_profile'] 
    
    # Map the ORCID profile fields to the local profile fields   
    return {
      :family_name  => profile['orcid_bio']['personal_details']['family_name'],
      :given_names => profile['orcid_bio']['personal_details']['given_names'],
      :vocative_name => profile['orcid_bio']['personal_details']['vocative_name']
    }
  end

  def retrieve_orcid_works

  end
  
  def update_orcid_bio

  end
  
end
