module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))  
  end
  
  def current_time
    Time.new(
      Time.now.year,
      Time.now.month,
      Time.now.day,
      Time.now.hour,
      Time.now.min, 0
    )
  end
  
  # 不正な値があるか確認する
  def attendances_invalid?
    attendances = true
    attendances_params.each do |id, item|
      if item[:started_at].blank? && item[:finished_at].blank?
        next
      elsif item[:started_at].blank? || item[:finished_at].blank?
        attendances = false
        break
      elsif item[:started_at] > item[:finished_at]
        attendances = false
        break
      end
    end
    return attendances
  end
  
  def notice_one_month_invalid?
    notice_one_month = true
    notice_edit_params.each do |id, item|
      if item[:notice_one_month_instructor_confirmation].blank? && item[:change_digest] == '0'  
        notice_one_month = false
        next
      elsif item[:notice_one_month_instructor_confirmation].blank? || item[:change_digest] == '0'
        notice_one_month = false
      end
    end
    return notice_one_month
  end
  
  def notice_overwork_invalid?
    notice_overwork = true
    notice_overwork_params.each do |id, item|
      if  item[:instructor_confirmation_app].blank? && item[:overwork_change] == '0'  
        notice_overwork = false
        next
      elsif item[:instructor_confirmation_app].blank? || item[:overwork_change] == '0'
        notice_overwork = false
      end
    end
    return notice_overwork
  end
  
  def approval_invalid?
    approval = true
    approval_params.each do |id, item|
      if item[:approval_application].blank?
        approval = false
        next
      elsif item[:approval_application].blank?
        approval = false
      end
    end
    return approval
  end
  
  def notice_approval_invalid?
    notice_approval = true
    notice_approval_params.each do |id, item|
      if item[:approval_confirmation].blank? && item[:approval_change] == '0'  
        notice_approval = false
        next
      elsif item[:approval_confirmation].blank? || item[:approval_change] == '0'
        notice_approval = false
      end
    end
    return notice_approval
  end
  
  def user_attendances_month_date
    @user.attendances.where('worked_on >= ? and worked_on <= ?', @first_day, @last_day).order('worked_on')
  end
end