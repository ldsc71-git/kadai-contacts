class User < ApplicationRecord
  before_save { self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :phone, presence: false, length: { maximum: 25 },
                    format: { with: /\A[\d#\*\-]+\z/ },
                    :allow_blank => true
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :contacts, dependent: :destroy
  
  has_many :messages, dependent: :destroy
#  has_many :qrcodes, dependent: :destroy

#  has_many :user_messages, dependent: :destroy
#  has_many :conversations, through: :user_messages, source: :message, dependent: :destroy

#  def make_conversation(new_message)
#    self.user_messages.find_or_create_by(message_id: new_message.id)
#  end
  
end
