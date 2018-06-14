require 'smart_proxy_m2/m2_api'

map '/m2' do
  run Proxy::M2::Api
end
