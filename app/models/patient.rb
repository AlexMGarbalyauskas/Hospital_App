class Patient < ApplicationRecord
  has_one_attached :profile_pic

  validates :name, :age, :diagnosis, :critical_status, :treatment_status, presence: true
  validates :living_status, presence: true


  before_save :assign_age_group

  def assign_age_group
    self.age_group =
      if age < 13
        "Child"
      elsif age < 60
        "Adult"
      else
        "Senior"
      end
  end
end
