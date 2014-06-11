module ApartmentSpree
  class Elevators
    class Subdomain
      attr_reader :app, :env

      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env
        current_tenant ? process_request : process_failure
      end

      private

      def process_request
        switch_tenant
      rescue => e
        failed_tenant_with e
      end

      def current_tenant
        @tenant ||= fetch_tenant
      end

      def switch_tenant
        tenant_schema = current_tenant.gsub! '-', '_'
        Apartment::Database.switch tenant_schema
        Rails.logger.error " Using db #{tenant_schema}"
        set_cache_id tenant_schema

        app.call env
      end

      def fetch_tenant
        request = ActionDispatch::Request.new env
        Rails.logger.error "  Requested URL: #{request.url}"
        subdomain_for request
      end

      def failed_tenant_with(ex)
        Rails.logger.error " Request failed with: #{ex.message}"
        set_cache_id
        Apartment::Database.switch nil
        ActionRecord::Base.establish_connection

        process_failure
      end

      def subdomain_for(request)
        request.subdomain.to_s.split('.').first
      end

      def process_failure
        [200, {'Content-type' => 'text/html'}, ['Ahh No.']]
      end

      def set_cache_id(id = '')
        ENV['RAILS_CACHE_ID'] = id
      end
    end
  end
end
