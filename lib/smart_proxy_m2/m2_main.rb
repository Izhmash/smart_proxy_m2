require 'net/http'
require 'uri'

module Proxy::M2
  extend ::Proxy::Util
  extend ::Proxy::Log

  class << self

    def test
      Proxy::M2::Plugin.settings.test_msg
    end

    def create_disk(disk_name, image_name, project = Proxy::M2::Plugin.settings.bmi_project)
      uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint + '/create_disk')
      put = Net::HTTP::Put.new(uri, 'content-type' => 'application/x-www-form-urlencoded')
      put.basic_auth Proxy::M2::Plugin.settings.bmi_username, 
                     Proxy::M2::Plugin.settings.bmi_password

      Net::HTTP.new(uri.host, uri.port).start do |http|
        response = http.request(put, "project=" + project + "&disk_name=" + disk_name + "&img=" + image_name)
        response.read_body
      end
    end

    def delete_disk(disk_name, project = Proxy::M2::Plugin.settings.bmi_project)
      project = Proxy::M2::Plugin.settings.bmi_project

      uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint + '/delete_disk')
      delete = Net::HTTP::Delete.new(uri, 'content-type' => 'application/x-www-form-urlencoded')
      delete.basic_auth Proxy::M2::Plugin.settings.bmi_username,
                        Proxy::M2::Plugin.settings.bmi_password

      Net::HTTP.new(uri.host, uri.port).start do |http|
        response = http.request(delete, "project=" + project + "&disk_name=" + disk_name)
        response.read_body
      end
    end

    def get_images(project = Proxy::M2::Plugin.settings.bmi_project)
      uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint + '/list_images/')
      post = Net::HTTP::Post.new(uri, 'content-type' => 'application/x-www-form-urlencoded')
      post.basic_auth Proxy::M2::Plugin.settings.bmi_username, 
                      Proxy::M2::Plugin.settings.bmi_password

      Net::HTTP.new(uri.host, uri.port).start do |http|
        response = http.request(post, "project=" + project)
        response.read_body
      end
    end

    def get_iscsi_target(disk_name, image_name, project = Proxy::M2::Plugin.settings.bmi_project)
      img = create_disk(disk_name, image_name, project)
      # Parse our quote marks and http
      uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint)
      iscsi =  "iscsi:#{uri.host}:::1:#{img}"
      iscsi.gsub! '"', ''
      return iscsi

    end

    def get_snapshots(project = Proxy::M2::Plugin.settings.bmi_project)
      uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint + '/list_snapshots/')
      post = Net::HTTP::Post.new(uri, 'content-type' => 'application/x-www-form-urlencoded')
      post.basic_auth Proxy::M2::Plugin.settings.bmi_username, 
                      Proxy::M2::Plugin.settings.bmi_password

      Net::HTTP.new(uri.host, uri.port).start do |http|
        response = http.request(post, "project=" + project)
        response.read_body
      end
    end
  end
end
