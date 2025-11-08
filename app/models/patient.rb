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

  # Card color for index/show pages
  def card_class
    case treatment_status
    when "Dead"
      "bg-dark text-white"
    when "Cured"
      "bg-success text-white"
    else
      "bg-light text-dark"
    end
  end

  # Title to display instead of name if Dead/Cured
  def title_status
    case treatment_status
    when "Dead" then "DEAD"
    when "Cured" then "CURED"
    else
      nil
    end
  end
end
