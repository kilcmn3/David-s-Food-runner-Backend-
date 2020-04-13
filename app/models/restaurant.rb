class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :comments, through: :users
  has_many_attached :image
  
  def save_database(datas)
      datas.each do |data|
        
      end
  end
end
