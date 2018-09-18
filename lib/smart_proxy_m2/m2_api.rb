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
      if params.key?(:project)
        Proxy::M2.get_images(params[:project])
      else
        Proxy::M2.get_images
      end
    end

    get '/iscsi_target' do
      if params.key?(:project)
        Proxy::M2.get_iscsi_target(params[:disk], params[:image], params[:project])
      else
        Proxy::M2.get_iscsi_target(params[:disk], params[:image])
      end
    end

    delete '/iscsi_target' do
      if params.key?(:project)
        Proxy::M2.delete_disk(params[:disk], params[:project])
      else
        Proxy::M2.delete_disk(params[:disk])
      end
    end

    get '/snapshot_list' do
      if params.key?(:project)
        Proxy::M2.get_snapshots(params[:project])
      else
        Proxy::M2.get_snapshots
      end
    end
  end
end
