# These helpers are useful for retrieving & manipulating ORCID profile data

require 'oauth2'
require 'multi_xml'

module OrcidProfileHelper
  Rails.logger.debug "Retrieving profile data from ORCID API at #{Rails.configuration.orcid[:site]} as client app #{Rails.configuration.orcid[:client_id]}"
  CLIENT = OAuth2::Client.new Rails.configuration.orcid[:client_id], 
                              Rails.configuration.orcid[:client_secret],
                              :site => Rails.configuration.orcid[:site]
  
  # Prepare the OAuth token needed to make the Tier 2 API call
  def build_token(access_token)
    return OAuth2::AccessToken.new CLIENT, access_token
  end
  
  def retrieve_orcid_bio(orcid, access_token)
    
    Rails.logger.debug "Retrieving ORCID bio data for #{orcid} using access token #{access_token}"

    # Prepare and send the OAuth request with the single-use token
    # ToDo proper exception handling
    response = build_token(access_token).get "/#{orcid}/orcid-bio"
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
