class ContactsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @contacts = current_user.contacts.order(name: :asc).page(params[:page])
  end

  def show
    @contact = current_user.contacts.find(params[:id])
  end

  def new
    @contact = current_user.contacts.build
  end

  def create
    @contact = current_user.contacts.build(contact_params)
    if @contact.save
      flash[:success] = '連絡先を保存しました。'
      redirect_to contact_url(@contact)
    else
      @contacts = current_user.contacts.order(name: :asc).page(params[:page])
      flash.now[:danger] = '連絡先の保存に失敗しました。'
      render :new
    end
  end
  
  def edit
    @contact = Contact.find(params[:id])
  end

  def update
    @contact = Contact.find(params[:id])

    if @contact.update(contact_params)
      flash[:success] = '連絡先は正常に更新されました'
      redirect_to @contact
    else
      flash.now[:danger] = '連絡先は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = '連絡先を削除しました。'
    redirect_to root_url
  end
  
  
  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :memo, :password, :password_confirmation)
  end
  
  def correct_user
    @contact = current_user.contacts.find_by(id: params[:id])
    unless @contact
      redirect_to root_url
    end
  end
end
