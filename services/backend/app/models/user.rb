class User < ApplicationRecord
  devise :invitable, :confirmable, :database_authenticatable, :invitable,
    :lockable, :recoverable, :rememberable, :trackable, :validatable
end
