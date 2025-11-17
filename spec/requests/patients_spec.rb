require 'rails_helper'
require 'securerandom'

RSpec.describe "Patients", type: :request do
  # Create a valid test user with required fields
  let!(:user) do
    User.create!(
      name: "Test User",  # required
      email: "test_user_#{SecureRandom.hex(4)}@example.com", # unique
      password: "password",
      password_confirmation: "password"
    )
  end

  # Valid patient attributes
  let(:valid_attributes) do
    {
      name: "John Doe",
      age: 35,
      diagnosis: "Cold",
      critical_status: "Stable",
      treatment_status: "In Progress"
    }
  end

  # Log in user before requests
  before do
    post sign_in_path, params: { email: user.email, password: "password" }
    expect(session[:user_id]).to eq(user.id)
  end

  describe "GET /patients" do
    it "returns a success response" do
      get patients_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /patients" do
    it "creates a new patient and redirects" do
      expect {
        post patients_path, params: { patient: valid_attributes }
      }.to change(Patient, :count).by(1)

      expect(response).to redirect_to(Patient.last)
    end
  end
end
