require 'rack'

module TTT
  module Web
    class ResetController
      def call(env)

        request = Rack::Request.new(env)
        request.session[:game] = nil

        response = Rack::Response.new
        response.redirect('/')
        response.finish
      end
    end
  end
end
