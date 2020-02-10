class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy]

  def show
    @user = current_user
    if params[:qr] == 'qr'
      Qrcode.where(user_id: current_user.id).destroy_all
      
      code = ('a'..'z').to_a.shuffle[0..10].join # コードを生成
      qr = Qrcode.new(user_id: current_user.id, qr: code)
      qr.save
      url1 = 'https://f4cb7ac819d54829977ddda5880d716b.vfs.cloud9.us-east-1.amazonaws.com'
      url2 = 'https://contacts-0203.herokuapp.com'
      @qr = 'https://chart.apis.google.com/chart?chs=200x200&cht=qr&chl=' + url2 + '/login/' + code
      @qr_url = url2 + '/login/' + code
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:success] = 'マイページは正常に更新されました'
      redirect_to user_path
    else
      flash.now[:danger] = 'マイページは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    current_user.destroy
    session[:user_id] = nil
    flash[:success] = '退会しました。'
    redirect_to login_url
  end
  
  
  private

  def user_params
    params[:user][:phone].gsub!(/\-/, '')
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
  end

end
