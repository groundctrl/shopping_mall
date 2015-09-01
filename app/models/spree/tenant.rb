module Spree
  class Tenant < ActiveRecord::Base
    validates :name, uniqueness: true
  end
end
