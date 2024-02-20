class DashboardController < ApplicationController
  

  def index
        
    @total_babies_registered = Child.count
    @scheduled_immunizations = ImmunizationSchedule.where("scheduled_date >= ?", Date.today).count
    @completed_immunizations = ImmunizationSchedule.where(status: true).count  
    @missed_immunizations = ImmunizationSchedule.where("scheduled_date < ? AND status = ?", Date.today, false).count
    @missed_schedules = ImmunizationSchedule.where("scheduled_date < ? AND status = ?", Date.today, false)
    @todays_scheduled_immunizations = ImmunizationSchedule.where(scheduled_date: Date.today).count
    @todays_immunizations = ImmunizationSchedule.where(scheduled_date: Date.today)

end
end
