json.extract! patient, :id, :name, :age, :diagnosis, :category, :addmitted_on, :age_group, :critical_status, :profile_pic, :created_at, :updated_at
json.url patient_url(patient, format: :json)
