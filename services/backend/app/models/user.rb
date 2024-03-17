class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :confirmable, :database_authenticatable, :invitable, :lockable, :recoverable,
    :trackable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
end
