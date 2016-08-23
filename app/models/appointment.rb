class Appointment < ApplicationRecord


  # validates :name, presence: true
  # validates :email, uniqueness: true, presence: true
  # validates :start_time, presence: true
  # validates :end_time, presence: true
  # validates :day, presence: true
  validates :month, presence: true
  validates :year, presence: true, numericality: { greater_than_or_equal_to: Time.now.year}
  validate :valid_check


  def valid_check

  end
end
