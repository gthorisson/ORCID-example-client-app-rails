# ORCID example client application in Rails

Rails 3 application which demonstrates how to do simple integration with the [ORCID API] (https://github.com/ORCID).

By [Gudmundur A. Thorisson] (http://www.gthorisson.name),University of Leicester / University of Iceland / ORCID


## Getting started 


### Install & run the ORCID API locally

Download the ORCID release from GitHub (https://github.com/ORCID/) and follow the instructions to start up the app on your local machine. This provides a bare-bones registry with a single contributor which exposes a nearly fully-functional API (see http://about.orcid.org/content/version-104-orcid-mock-api-released).

_Note: the API software will of course ultimately be operated by the ORCID organization as a centralized service. The standalone mode of operatio is intended purely for early development purposes._


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


### Register client app with the ORCID API

Follow instructions with the ORCID API application to register your client applicatiob as an OAuth consumer. Then add the consumer key+secret credentials your Rails config in ```config/initializers/omniauth.rb```:


```ruby
require 'omniauth'
require 'omniauth-orcid'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :orcid, '[CONSUMER KEY]','[CONSUMER SECRET]'
end
```


### Scenario A: User registers for account, then connects his account to an ORCID profile

.. got to registration page, fill in & submit in conventional way
.. then go to account page and click "Add ORCID account"


### Scenario B: User register and connects to ORCID in one go

..go to login page and click "Connect with ORCID" button.
..fill in additional profile info if needed.result


## Implementation notes

...


## More information 

The main ORCID website - http://about.orcid.org

The ORCID Technical Working Group - http://about.orcid.org/twg


## Acknowledgements


This work was supported in part by funds from the NIH Award, [VIVO: Enabling National Networking of Scientists] (http://www.vivoweb.org), U24 RR029822 and by the European Community’s Seventh Framework Programme (FP7/2007–2013) under contract grant number 200754 ([The GEN2PHEN Project] (http://www.gen2phen.org))




## License

=============================================================================
Copyright (C) 2012 by Gudmundur A. Thorisson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
=============================================================================
