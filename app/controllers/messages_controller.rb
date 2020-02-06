class MessagesController < ApplicationController
  def show
#    @messages = current_user.conversations.order(created_at: :asc).page(params[:page]).per(25)
    @user = get_recipient_user(params[:id])
    @messages = Message.where("(user_id = #{current_user.id} AND recipient_id = #{@user.id}) OR (user_id = #{@user.id} AND recipient_id = #{current_user.id})").order(created_at: :asc).page(params[:page]).per(25)
    @contact_user = current_user.contacts.find(params[:id])
    @message = Message.new
    # 既読にする
    @messages.where("user_id = #{@user.id} AND recipient_id = #{current_user.id}").update(unread: false)
  end

  def create
    @user = get_recipient_user(params[:user_id])
    @message = current_user.messages.build(message_params)
    @message.update(recipient_id: @user.id)

#    current_user.make_conversation(@message)
#    @user.make_conversation(@message)
    
    redirect_to message_path(current_user.contacts.find(params[:user_id]))
  end
  
  
  private

  def message_params
    params.require(:message).permit(:content)
  end
end
