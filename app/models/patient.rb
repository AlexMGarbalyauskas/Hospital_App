class Patient < ApplicationRecord
  has_one_attached :photo

  validate :acceptable_photo

  def acceptable_photo
    return unless photo.attached?

    unless photo.byte_size <= 2.megabytes
      errors.add(:photo, "is too big. Must be less than 2MB")
    end

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(photo.content_type)
      errors.add(:photo, "must be a JPEG or PNG")
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "diagnosis", "age", "admitted_on", "created_at", "updated_at", "id"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
