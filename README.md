# ORCID example client application in Rails

Simple Rails application to serve the role of an OAuth consumer which communicates with the [ORCID API] (https://github.com/ORCID).


## Getting started 


### Install & run the ORCID API locally

Download the ORCID release from GitHub (https://github.com/ORCID/) and follow the instructions to start up the app on your local machine. This provides a bare-bones registry with a single contributor which exposes a nearly fully-functional API (see http://about.orcid.org/content/version-104-orcid-mock-api-released).

_Note: the API software will of course ultimately be operated by the ORCID organization as a centralized service._



### Install & run Rails client app


```bash
[mummi@cambozola]git clone https://github.com/gthorisson/ORCID-example-client-app-rails.git
[mummi@cambozola]cd ORCID-example-client-app-rails/
[mummi@cambozola]bundle
[mummi@cambozola]rails server
=> Booting WEBrick
=> Rails 3.2.3 application starting in development on http://0.0.0.0:3000
=> Call with -d to detach
=> Ctrl-C to shutdown server
[2012-04-28 15:18:47] INFO  WEBrick 1.3.1
[2012-04-28 15:18:47] INFO  ruby 1.9.3 (2012-04-20) [x86_64-darwin11.3.0]
[2012-04-28 15:18:47] INFO  WEBrick::HTTPServer#start: pid=14838 port=3000
```

The open your browser at http://localhost:3000 and verify that the client app is running.

[screenshot]


### Register client app as an OAuth consumer with the ORCID API

Follow instructions with the ORCID API application to register your client application with the service. Then add the consumer key+secret credentials your Rails config in ```config/initializers/omniauth.rb```:

require 'omniauth'
require 'omniauth-orcid'

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :orcid, '[CONSUMER KEY]','[CONSUMER SECRET]'
end
```


### Scenario A: use registers for account, then connects his account to an ORCID profile

.. got to registration page, fill in & submit in conventional way
.. then go to account page and click "Add ORCID account"


### Scenario B: Register user and connect to ORCID in one go

..go to login page and click "Connect with ORCID" button
..fill in additional profile info if needed





