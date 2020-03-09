class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month, :update_overwork_request, :edit_overwork_request,
                                  :update_overwork_request, :notice_overwork_request, :update_notice_overwork_request,
                                  :notice_edit_one_month, :update_notice_overwork_request]
  before_action :logged_in_user, only: [:update, :edit_one_month, :notice_overwork_request, :update_overwork_request, :edit_overwork_request,
                                  :update_overwork_request, :notice_overwork_request, :update_notice_overwork_request,
                                  :notice_edit_one_month, :update_notice_overwork_request]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: [:edit_one_month, :edit_overwork_request, :notice_overwork_request, :notice_edit_one_month]
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end
  
  def create
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    if @attendance.started_at.nil?
      @attendance.update_attributes(started_at: current_time)
      flash[:info] = 'おはようございます。'
    else
      flash[:danger] = 'トラブルがあり、登録出来ませんでした。'
    end
    redirect_to @user
  end
  
  def edit_one_month
  end
  
  def update_one_month
    ActiveRecord::Base.transaction do
      if attendances_invalid?
        attendances_params.each do |id, item|
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
        flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
        redirect_to user_url(date: params[:date])
      else
        flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      end
    end
  rescue ActiveRecord::RecordInvalid
      flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
      redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end
  
  def notice_edit_one_month
    @attendance = Attendance.find(params[:id])
  end
  
  def update_notice_edit_month
  end
  
  
  def edit_overwork_request
    @user = User.find(params[:id])
    @day = Date.parse(params[:day])
    @attendance = Attendance.find(params[:id])
  end
      
  def update_overwork_request
    @attendance = Attendance.find(params[:id])
    @attendance.update_attributes(overwork_request_params)
    flash[:info] = "残業申請を送信しました。"
    redirect_to users_url
  end
  
  def notice_overwork_request
    @user = User.find(params[:id])
    @day = Attendance.find(params[:id])
    @attendance = Attendance.find(params[:id])
  end
  
  def update_notice_overwork_request
    @attendance = Attendance.find(params[:id])
    @attendance.update_attributes(overwork_request_params)
    flash[:info] = "変更内容を更新しました"
    redirect_to @attendance
  end
    
  private
    # １ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
    
    def overwork_request_params 
      params.require(:attendance).permit(attendances: [:worked_on, :expected_end_time, :next_day, 
                                                       :business_processing_contents, :instructor_confirmation])
    end
    
    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
end