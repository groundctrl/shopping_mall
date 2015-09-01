module Spree
  module Preferences
    ScopedStore.class_eval do
      private

      def rails_cache_id
        "#{ENV['RAILS_CACHE_ID']}#{Apartment::Tenant.current}"
      end
    end
  end
end
