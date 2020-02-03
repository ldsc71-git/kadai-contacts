class Contact < ApplicationRecord
  belongs_to :user
  
  unless :email.empty?
    before_save { self.email.downcase! }
  end
  
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: false, length: { maximum: 25 }


  validates :email, presence: false, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    :allow_blank => true
end
