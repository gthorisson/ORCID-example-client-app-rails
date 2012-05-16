require 'omniauth'
require 'omniauth-orcid'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'eSX0sdHDODy1bdUFX5oAw', 'Wdh2Eo5CtYrIVfeogDVrjjMa6dee18H96FCqdCYc'
  provider :orcid, '0000-0002-7649-0259','5a81472f-d318-4823-887a-ea64ac6f680a'
end
