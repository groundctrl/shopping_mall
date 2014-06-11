module ApartmentSpree
  class Elevators
    class Subdomain
      attr_reader :app, :env

      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env
        current_tenant_subdomain ? process_request : process_failure
      end

      private

      def process_request
        switch_tenant_schema
      rescue => e
        fail_tenant_with e
      end

      def current_tenant_subdomain
        @tenant ||= tenant_subdomain
      end

      def tenant_subdomain
        request = ActionDispatch::Request.new env
        Rails.logger.warn "Requested URL: #{request.url}"
        request.subdomain.to_s.split('.').first
      end

      def switch_tenant_schema
        tenant_schema = current_tenant_subdomain.gsub '-', '_'
        cache_id tenant_schema
        Apartment::Database.switch tenant_schema
        Rails.logger.warn "Using db #{tenant_schema}"

        app.call env
      end

      def fail_tenant_with(ex)
        cache_id
        Apartment::Database.switch nil
        ActiveRecord::Base.establish_connection
        Rails.logger.error " Request failed with: #{ex.message}"

        process_failure
      end

      def process_failure
        [200, { 'Content-type' => 'text/html' }, ['Ahh No.']]
      end

      def cache_id(id = '')
        ENV['RAILS_CACHE_ID'] = id
      end
    end
  end
end
