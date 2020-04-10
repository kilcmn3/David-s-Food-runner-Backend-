class Comment < ApplicationRecord
  belongs_to :user
  has_many :restaurants, through: :users
end
