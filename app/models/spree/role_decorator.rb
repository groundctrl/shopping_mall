Spree::Role.class_eval do
  has_many :roles_users
  has_many :users,
           through: :roles_users,
           class_name: 'Spree::RolesUser'
end
