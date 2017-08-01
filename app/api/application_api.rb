class ApplicationAPI < Grape::API
  prefix ''
  use ActionDispatch::RemoteIp

  format :json
  content_type :json, 'application/json;charset=utf-8'

  require 'v1/root.rb'
  mount API::V1::Root

  route :any, '*path' do
    status 404
    { error: 'Page not found.' }
  end

end
