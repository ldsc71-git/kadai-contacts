class SessionsController < ApplicationController
  def new
    unless params[:qr].nil?
      session[:qr] = params[:qr]
    end
      
    qr_user = Qrcode.find_by(qr: session[:qr])
    if qr_user && qr_user.user_id != session[:user_id] && session[:user_id].nil? == false
      check_qrcode
      redirect_to contacts_url
    end
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]

    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      check_qrcode
      
      redirect_to contacts_url
    else
      flash.now[:danger] = 'ログインに失敗しました。'
      if params[:qr].nil?
        render :new
      else
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to login_url
  end
  
  
  private

  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      # ログイン成功
      session[:user_id] = @user.id
      return true
    else
      # ログイン失敗
      return false
    end
  end
  
  def check_qrcode
    # QRコードによる連絡先登録
    qr_user = Qrcode.find_by(qr: session[:qr])
    if qr_user
      # 相手を自分の連絡先に登録
      new_user = User.find(qr_user.user_id)
      new_contact = current_user.contacts.build(name: new_user.name, phone: new_user.phone, email: new_user.email, memo: '')
      new_contact.save
      # 自分を相手の連絡先に登録
      new_contact = new_user.contacts.build(name: current_user.name, phone: current_user.phone, email: current_user.email, memo: '')
      new_contact.save
      qr_user.destroy
      session[:qr] = nil
      
      flash[:success] = 'QRコードで連絡先を登録しました。'
    end
  end
end
