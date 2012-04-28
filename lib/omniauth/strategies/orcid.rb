require 'omniauth-oauth2'
require 'multi_json'

# OmniAuth strategy for connecting to the ORCID contributor ID service via the OAuth 2.0 protocol

module OmniAuth
  module Strategies
    class ORCID < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'http://localhost:8080',
        :authorize_url => '/oauth/user/authorize',
        :token_url => '/oauth/token',
        :scope => '/orcid-profile/read-protected',
        :response_type => 'code',
        :mode => :header
      }

      uid { raw_info['orcid.orcid'] }

      info do
        {
          # TODO match this up with the ORCID profile fields!!
          'email' => raw_info['email'],
          'name' => raw_info['orcid.orcid-bio']['orcid.personal-details']['orcid.credit-name'],
          'urls' => {
            'ORCID profile' => raw_info['profile_uri']
          },
        }
      end

      extra do
        {:raw_info => raw_info}
      end

      # Modify how the request is made
      def request_phase
        options[:scope] ||= '/orcid-profile/read-protected'

        # think I can pass in a redirect URL like this
        #options[:redirect_url] ||= [account page]
        Rails.logger.debug "In request_phase, got options " + options.inspect
        super
      end


      # Retrieve profile data via the OAuth::Access object, and return as hash
      def raw_info
        #access_token.options[:mode] = :header
        
        # Make signed request to retrieve profile data as JSON
        # !!!ATTN the contributor ID string is hardcoded here for now !!!
        begin
          Rails.logger.debug "Retrieving profile data as JSON using token: " 
          response = access_token.get('/t1/4444-4444-4444-4446/orcid-profile', :headers => {'Accept'=>'application/json'})
        rescue ::OAuth2::Error => e
          Rails.logger.error "Error in retrieving profile data, dumping error msg to STDOUT"
          raise e.response.inspect
        end

        userhash = MultiJson.decode(response.body)['orcid.orcid-message']['orcid.orcid-profile']
        userhash['profile_uri']  = 'http://localhost:8080/t1/4444-4444-4444-4446'
        userhash['profile_format']  = 'application/json'
        Rails.logger.debug userhash.inspect
        # Preparing hash as per OmniAuth convention
        @raw_info = userhash
      end
    end
  end
end

OmniAuth.config.add_camelization 'orcid', 'ORCID'
