# app/models/patient.rb

# Patient model representing patients in the hospital
# used to store patient information

class Patient < ApplicationRecord

  # profile picture attachment
  has_one_attached :profile_pic

  # Validations (remove living_status)
  validates :name, :age, :diagnosis, :critical_status, :treatment_status, presence: true

  # Callbacks
  before_validation :assign_age_group_and_living_status

  private

  # Assign age_group and living_status automatically
  def assign_age_group_and_living_status
    self.age_group =
      if age.present?
        if age < 13
          "Child"
        elsif age < 60
          "Adult"
        else
          "Senior"
        end
      end

    self.living_status =
      case treatment_status
      when "Dead" then "Dead"
      else "Alive"
      end
  end
end
