class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy,
                                  :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show
  before_action :admin_or_correct_user, only: :show
  before_action :notice, only: :show
  
  def index
    @users = User.all
    @user = User.new
  end
  
  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    flash[:success] = '新規作成に成功しました。'
    redirect_to users_url
  end
  
  def show
    @users = User.all
    @attendance = Attendance.find(params[:id])
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def new
    if logged_in? && !current_user.admin?
      flash[:info] = 'すでにログインしています。'
      redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  def edit_basic_info
  end
  
  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end
  
  def index_attendance
    @users = User.all.includes(:attendances)
  end
  
  def approval_application
    @attendance = Attendance.find(params[:id])
    @attendance.update_attributes(approval_params)
    flash[:info] = "申請しました"
    redirect_to user_url
  end
  
  def notice_approval_application
    @users = User.all
    @attendance = Attendance.find(params[:id])
    @user = User.find(params[:id])
  end
  
  def update_notice_approval_application
    @attendance = Attendance.find(params[:id])
    @attendance.update_attributes(approval_params)
    flash[:info] = "変更しました"
    redirect_to user_url
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :department,
                                   :password, :password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:name, :email, :department, :basic_time,
                                   :password, :password_confirmation, :uid, :employee_number)
    end
    
    def basic_params
      params.require(:user).permit(:name, :email, :department, :basic_time,
                                   :password, :password_confirmation, :uid, :employee_number)
    end
    
    def approval_params
      params.require(:attendance).permit(:approval_application, :approval_confirmation)
    end
end