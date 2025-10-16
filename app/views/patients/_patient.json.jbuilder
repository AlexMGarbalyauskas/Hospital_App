json.extract! patient, :id, :name, :age, :diagnosis, :admitted_on, :created_at, :updated_at
json.url patient_url(patient, format: :json)
