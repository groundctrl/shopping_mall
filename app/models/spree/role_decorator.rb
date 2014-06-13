Spree::Role.class_eval do
  has_many :roles_users, class_name: 'Spree::RolesUser'
  has_many :users, through: :roles_users, class_name: 'Spree::User'
end
