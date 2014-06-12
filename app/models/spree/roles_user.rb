module Spree
  class RolesUser < ActiveRecord::Base
    belongs_to :role, class_name: 'Spree::Role', foreign_key: "user_id"
    belongs_to :user, class_name: 'Spree::User'
  end
end
