module ApartmentSpree
  class Elevators
    class Subdomain
      attr_reader :env, :failure, :success

      def initialize(app)
        @success = app
        @failure = ->(env) do
          [200, { 'Content-type' => 'text/html' }, ['No tenant.']]
        end
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

      def tenant_schema_name
        @schema_name ||= current_tenant_subdomain.gsub('-', '_')
      end

      def tenant_subdomain
        ActionDispatch::Request.new(env).subdomain.to_s.split('.').first
      end

      def switch_tenant_schema
        cache_id tenant_schema_name
        Apartment::Database.switch tenant_schema_name
        process_success
      end

      def fail_tenant_with(ex)
        cache_id && Rails.logger.error("Request failed with: #{ex.message}")
        process_failure
      end

      def process_success
        success.call env
      end

      def process_failure
        failure.call env
      end

      def cache_id(id = '')
        ENV['RAILS_CACHE_ID'] = id
      end
    end
  end
end
