require 'grape-swagger'
require 'doorkeeper/grape/helpers'

module API
  module V1

    class Root < Grape::API
      version 'v1'

      default_error_formatter :json
      content_type :json, 'application/json;charset=utf-8'

      format :json
      formatter :json, Grape::Formatter::ActiveModelSerializers

      rescue_from :all do |e|
        case e
        when ActiveRecord::RecordNotFound
          Rack::Response.new([{result: false, error: '数据不存在'}.to_json], 404, {}).finish
        when Grape::Exceptions::ValidationErrors
          Rack::Response.new([{
            result: false,
            error: '参数错误，请检查参数是否符合API要求。',
            validation_errors: e.full_messages
          }.to_json], 400, {}).finish
        else
          if Rails.env.test?
            Rails.logger.error("Error: #{e}\n#{e.backtrace[0..3].join("\n")}")
          else
            Rails.logger.error("API V1 Error: #{e}\n#{e.backtrace[0..3].join("\n")}")
          end
          Rack::Response.new([{result: false, error: 'API接口异常'}.to_json], 500, {}).finish
        end
      end

      helpers Doorkeeper::Grape::Helpers

      require 'v1/helpers'
      helpers API::V1::Helpers

      require 'v1/topics'
      mount API::V1::Topics

      require 'v1/pictures'
      mount API::V1::Pictures

      desc '简单的API测试接口，需要access_token验证，便于快速测试OAuth 2.0'
      get 'hello' do
        doorkeeper_authorize!
        render result: true, user: current_user, meta: { time: Time.now }
      end

      # API文档
      add_swagger_documentation \
        doc_version: 'v1'

    end    # class end

  end      # module v1 end
end        # module API end
