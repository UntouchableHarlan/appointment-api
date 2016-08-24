class Appointment < ApplicationRecord


  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :day, presence: true
  validates :month, presence: true
  validates :year, presence: true, numericality: { greater_than_or_equal_to: Time.now.year}
  validate  :month_selected,

  def valid_check
    @valid = true
    validate_month
    validate_start_time
    end_time_validation
    check_to_see_if_appointments_exist
  end
# Cant make appointment if its a second back --------------------
  def validate_month
    if self.month.length > 2 # assumes month is a name if longer than 2 chars
      @number_month = Date::MONTHNAMES.index(self.month.capitalize)
      if @number_month < Time.now.month
        self.month = @number_month
      else
        @valid = false
      end
    end
  end

  def validate_start_time
    # hour, min = self.start_time.split(":").map(&:to_i)
    @ps = self.start_time.split(":")
    hour = @ps[0].to_i
    min = @ps[1].to_i
    if Time.mktime(self.year, @number_month, self.day.to_i, hour, min) < Time.now
        @valid = false
    end
  end

  def end_time_validation
    @start_time = Time.parse(self.start_time)
    @end_time = Time.parse(self.end_time)
    if @end_time < @start_time
      @valid = false
    else
      return true
    end
  end
# ----------------------------------------------------------
  def check_to_see_if_appointments_exist
    @look_start_appointment = where(start_time: @start_time)
    @look_end_appointment = where(end_time: @end_time)
    # @appts = where(
    #   "start_time (BETWEEN ? AND ?) OR end_time (BETWEEN ? AND ?)",
    #   [@start_time, @end_time, @start_time, @end_time]
    # )
    # return false if @appts.exist
    @look_start_appointment.each do |s|
      if @start_time == s.start_time..s.end_time
        @valid = false
        puts "no good"
      end
    end
    @look_end_appointment.each do |s|
      if @end_time == s.start_time..s.end_time
        @valid = false
        puts "no good"
      end
    end
  end
end
