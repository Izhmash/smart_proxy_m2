module Proxy::M2
  class NotFound < RuntimeError; end

  class Plugin < ::Proxy::Plugin
    plugin 'm2', Proxy::M2::VERSION

    default_settings test_msg: 'test'
    default_settings bmi_endpoint: 'http://localhost'
    default_settings bmi_username: 'user'
    default_settings bmi_password: 'pass'
    default_settings bmi_project: 'bmi_infra'

    http_rackup_path File.expand_path('m2_http_config.ru', File.expand_path(__dir__))
    https_rackup_path File.expand_path('m2_http_config.ru', File.expand_path(__dir__))
  end
end
