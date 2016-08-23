class Appointment < ApplicationRecord


  # validates :name, presence: true
  # validates :email, uniqueness: true, presence: true
  # validates :start_time, presence: true
  # validates :end_time, presence: true
  # validates :day, presence: true
  validates :month, presence: true
  validates :year, presence: true, numericality: { greater_than_or_equal_to: Time.now.year}

  def valid_check
    @valid = true
    validate_month
  end

  def validate_month
    number_month = Date::MONTHNAMES.index(self.month.capitalize)
    if number_month < Time.now.month
      @valid = false
    else
      self.month = number_month
    end
  end

  def validate_day

  end
end
