require 'sinatra'
require 'smart_proxy_m2/m2'
require 'smart_proxy_m2/m2_main'
require 'json'

module Proxy::M2

  class Api < ::Sinatra::Base
    include ::Proxy::Log
    helpers ::Proxy::Helpers

    get '/test' do
      Proxy::M2.test
    end

		get '/image_list' do
			Proxy::M2.get_images(params[:project])
		end

		get '/iscsi_target' do
			Proxy::M2.get_iscsi_target(params[:project], params[:image])
		end

  end
end
