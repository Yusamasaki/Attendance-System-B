class AddDesignatedWorkTimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :designated_work_start_time, :datetime, default: Time.current.change(hour: 10, min: 0, sec: 0)
    add_column :attendances, :designated_work_end_time, :datetime, default: Time.current.change(hour: 19, min: 0, sec: 0)
  end
end
  