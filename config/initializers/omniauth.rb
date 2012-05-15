require 'omniauth'
require 'omniauth-orcid'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'eSX0sdHDODy1bdUFX5oAw', 'Wdh2Eo5CtYrIVfeogDVrjjMa6dee18H96FCqdCYc'
#  provider :linked_in, 'wuMhoPkGgwUceF_btprE1PVs8odcSTGDxJDeHRwsDKfYPAjROJmTDvBcvs1hBsU3', 'BMujro7Ee-S2oA6vLbisyWvpjg9eROFuayVMu0aq2iUToCvOPR2-m9uxoqQ_i59R'  
  provider :orcid, '8933-0264-7715-6870','1ae28805-be96-4899-891a-a00159625745'
end
