class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to user
         
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
  
    else
      flash.now[:danger] = 'Invalid email/password combination'
      #flash[:danger] = 'Invalid email/password combination' # 本当は正しくない
      render 'new'  # エラーメッセージを作成する
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end