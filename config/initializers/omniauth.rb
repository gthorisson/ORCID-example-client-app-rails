require 'omniauth-orcid'

Rails.application.config.middleware.use OmniAuth::Builder do

  orcid_yml     = YAML.load_file(File.join(Rails.root, "config", "orcid.yml"))
  settings = orcid_yml[Rails.env].symbolize_keys!
  puts "Connecting to ORCID API at " + settings[:site] + " as client app #{settings[:client_id]}"
  provider :orcid, settings[:client_id], settings[:client_secret], 
  :client_options => {
    :site => settings[:site],
    :authorize_url => settings[:authorize_url],
    :token_url => settings[:token_url]
  }

end
