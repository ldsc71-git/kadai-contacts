module ApplicationHelper
  # contactsテーブルのidからusersテーブルのuserを取得
  def get_recipient_user(contact_id)
    contact_user = current_user.contacts.find(contact_id)
    user = User.find_by(phone: contact_user.phone)
    if user
      user
    else
      current_user
    end
  end
  
  # 未読のメッセージをカウント
  def count_messages_receiver(contact_id)
    @user = get_recipient_user(contact_id)
    Message.where("user_id = #{@user.id} AND recipient_id = #{current_user.id} AND unread = TRUE").count
  end
  
  def count_messages_sender(contact_id, message_id)
    @user = get_recipient_user(contact_id)
    Message.where("user_id = #{current_user.id} AND recipient_id = #{@user.id} AND unread = TRUE AND id = #{message_id}").count
  end
end
