class Message < ApplicationRecord
  belongs_to :user
#  has_many :user_messages, dependent: :destroy
end
