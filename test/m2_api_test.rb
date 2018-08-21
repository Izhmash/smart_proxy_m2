require 'test_helper'
require 'webmock/test_unit'
require 'mocha/test_unit'
require 'rack/test'

require 'smart_proxy_m2/m2'
require 'smart_proxy_m2/m2_api'

class M2ApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Proxy::M2::Api.new
  end

  def test_test
    Proxy::M2::Plugin.load_test_settings('test_msg' => 'test')
    assert get('/test').body == 'test'
  end

  def test_image_list
    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:post, "http://localhost/list_images/"). with( body: {"project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_image", headers: {})

    get '/image_list?project=bmi_infra'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("test_image", last_response.body)

  end

  def test_image_list_default_project
    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:post, "http://localhost/list_images/"). with( body: {"project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_image", headers: {})

    get '/image_list'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("test_image", last_response.body)

  end

  def test_get_target

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:put, "http://localhost/create_disk"). with( body: {"disk_name"=>"test_disk", "img"=>"test_image", "project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_target", headers: {})

    get '/iscsi_target?project=bmi_infra&disk=test_disk&image=test_image'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("iscsi:localhost:::1:test_target", last_response.body)

  end

  def test_get_target_default_project

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:put, "http://localhost/create_disk"). with( body: {"disk_name"=>"test_disk", "img"=>"test_image", "project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_target", headers: {})

    get '/iscsi_target?disk=test_disk&image=test_image'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("iscsi:localhost:::1:test_target", last_response.body)

  end

  def test_delete_target

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:delete, "http://localhost/delete_disk"). with( body: {"disk_name"=>"test_disk", "project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "Success", headers: {})

    delete '/iscsi_target?project=bmi_infra&disk=test_disk'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("Success", last_response.body)

  end

  def test_delete_target_default_project

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:delete, "http://localhost/delete_disk"). with( body: {"disk_name"=>"test_disk", "project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "Success", headers: {})

    delete '/iscsi_target?disk=test_disk'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("Success", last_response.body)

  end

  def test_get_snapshots

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:post, "http://localhost/list_snapshots/"). with( body: {"project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_snapshot", headers: {})

    get '/snapshot_list?project=bmi_infra'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("test_snapshot", last_response.body)

  end

  def test_get_snapshots_default_project

    Proxy::M2::Plugin.load_test_settings('bmi_username' => 'user')
    Proxy::M2::Plugin.load_test_settings('bmi_password' => 'pass')
    Proxy::M2::Plugin.load_test_settings('bmi_project' => 'bmi_infra')

    stub_request(:post, "http://localhost/list_snapshots/"). with( body: {"project"=>"bmi_infra"}, headers: { 'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic dXNlcjpwYXNz', 'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'localhost', 'User-Agent'=>'Ruby' }). to_return(status: 200, body: "test_snapshot", headers: {})

    get '/snapshot_list'
    assert last_response.ok?, "Last response was not ok: #{last_response.body}"
    assert_equal("test_snapshot", last_response.body)

  end
end
