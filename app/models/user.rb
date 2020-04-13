class User < ApplicationRecord
    has_many :comments
    has_many :restaurants, through: :comments
end
