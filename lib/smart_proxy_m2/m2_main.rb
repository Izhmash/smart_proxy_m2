require 'net/http'
require 'uri'

module Proxy::M2
  extend ::Proxy::Util
  extend ::Proxy::Log

  class << self

    def test
      Proxy::M2::Plugin.settings.test_msg
    end

		def get_images(project)
			uri = URI.parse(Proxy::M2::Plugin.settings.bmi_endpoint + '/list_images/')
			post = Net::HTTP::Post.new(uri, 'content-type' => 'application/x-www-form-urlencoded')
			post.basic_auth Proxy::M2::Plugin.settings.bmi_username, 
											Proxy::M2::Plugin.settings.bmi_password

			Net::HTTP.new(uri.host, uri.port).start do |http|
				response = http.request(post, "project=" + project)
				response.read_body
			end
		end

		def get_iscsi_target(project, img)
			# Placeholder for new M2 "pro" command:
			#return JSON['iscsi_target' => "#{project}; #{img}; sample_target"]
			return "#{project}-#{img}-sample_target"
		end
  end

end
