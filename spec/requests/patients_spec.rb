# spec/requests/patients_spec.rb
require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe "GET /patients" do
    it "returns a success response" do
      get patients_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /patients" do
    it "creates a new patient and redirects" do
      post patients_path, params: {
        patient: {
          name: "John Doe",
          age: 35,
          diagnosis: "Cold",
          critical_status: "Stable",
          treatment_status: "In Progress"
        }
      }

      expect(response).to redirect_to(Patient.last)
      follow_redirect!
      expect(response.body).to include("Patient created successfully")
    end
  end
end
