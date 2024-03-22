class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :confirmable, :database_authenticatable, :lockable, :recoverable, :trackable,
    :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
