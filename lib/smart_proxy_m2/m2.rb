module Proxy::M2
  class NotFound < RuntimeError; end

  class Plugin < ::Proxy::Plugin
    plugin 'm2', Proxy::M2::VERSION

    default_settings :hello_greeting => 'O hai!'

    http_rackup_path File.expand_path('m2_http_config.ru', File.expand_path('../', __FILE__))
    https_rackup_path File.expand_path('m2_http_config.ru', File.expand_path('../', __FILE__))
  end
end
