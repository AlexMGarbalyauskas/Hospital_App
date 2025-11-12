# spec/models/patient_spec.rb
require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is valid with valid attributes" do
    patient = Patient.new(
      name: "John Doe",
      age: 25,
      diagnosis: "Flu",
      critical_status: "Stable",
      treatment_status: "Under treatment"
    )
    expect(patient).to be_valid
  end

  it "is invalid without a name" do
    patient = Patient.new(age: 25, diagnosis: "Flu", critical_status: "Stable", treatment_status: "Under treatment")
    expect(patient).to_not be_valid
  end
end
