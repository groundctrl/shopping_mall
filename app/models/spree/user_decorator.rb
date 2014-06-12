Spree::User.class_eval do
  has_many :roles_users
  has_many :roles,
           through: :roles_users,
           class_name: 'Spree::RolesUser'
end
