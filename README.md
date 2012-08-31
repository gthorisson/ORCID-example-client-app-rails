# ORCID example client application in Rails

Simple web application built with [Ruby on Rails](http://rubyonrails.org) and [Twitter Bootstrap](http://twitter.github.com/bootstrap/) which demonstrates how to do simple integration with the [ORCID API] (https://github.com/ORCID).

By [Gudmundur A. Thorisson] (http://www.gthorisson.name), University of Leicester / University of Iceland / ORCID


## Getting started


### Install Rails client app, create database and spin it up

```bash
[mummi@cambozola]git clone https://github.com/gthorisson/ORCID-example-client-app-rails.git
[mummi@cambozola]cd ORCID-example-client-app-rails/
[mummi@cambozola]bundle
[mummi@cambozola]rake db:setup
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


### Register client app with the ORCID test sandbox

The ORCID sandbox is now live at http://devsandbox.orcid.org . Go to the Developer portal for info on how to register a client app that can connect to the sandbox:

http://dev.orcid.org/docs


### Configure client app to connect to the ORCID sandbox

See http://dev.orcid.org/docs/api-code-examples-ruby


## Using the app

### Scenario A: User registers for account, then connects his account to an ORCID profile

* Go to registration page, fill in & submit in conventional way
* Then go to account page and click "Add ORCID account"


### Scenario B: User register and connects to ORCID in one go

* Go to login page and click "Connect with ORCID" button.
* Fill in additional profile info if needed


## OAuth implementation notes

The OAuth part of the client <-> ORCID connectivity is handled by the terrific [OmniAuth external authentication framework](http://www.omniauth.org). As with most other OAuth APIs in mainstream use, the "OAuth dance" is pretty straightforward and, importantly, standardized. So, only a simple [custom OAuth2 strategy](https://github.com/gthorisson/ORCID-example-client-app-rails/blob/master/lib/omniauth/strategies/orcid.rb) is needed to deal with setup and customization specific to the ORCID OAuth API.

See the [ORCID devsite](See http://dev.orcid.org/docs/api-code-examples-ruby
) for more details on the OAuth nuts&bolts.


## More information 

Main ORCID website - http://about.orcid.org

ORCID Technical Working Group - http://about.orcid.org/twg

ORCID Developer website - http://dev.orcid.org


## Acknowledgements


This work was supported in part by funds from the NIH Award, [VIVO: Enabling National Networking of Scientists] (http://www.vivoweb.org), U24 RR029822 and by the European Community’s Seventh Framework Programme (FP7/2007–2013) under contract grant number 200754 ([The GEN2PHEN Project] (http://www.gen2phen.org))



## License

The MIT License (OSI approved, see more at http://www.opensource.org/licenses/mit-license.php)

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

![Open Source Initiative Approved License](http://www.opensource.org/trademarks/opensource/web/opensource-110x95.jpg)

