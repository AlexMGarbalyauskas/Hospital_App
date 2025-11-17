require 'rails_helper'

RSpec.describe PatientsController, type: :controller do
  let(:valid_attributes) do
    {
      name: "John Doe",
      age: 40,
      diagnosis: "Flu",
      critical_status: "Stable",
      treatment_status: "In Progress"
    }
  end

  let(:invalid_attributes) do
    { name: "", age: nil, diagnosis: "", critical_status: "", treatment_status: "" }
  end

  before do
    # Create a user and simulate login
    @user = User.create!(name: "Test User", email: "test@example.com", password: "password")
    session[:user_id] = @user.id
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful # now should pass
    end
  end

  describe "POST #create" do
    it "creates a new patient with valid attributes" do
      expect {
        post :create, params: { patient: valid_attributes }
      }.to change(Patient, :count).by(1)
    end

    it "does not create a patient with invalid attributes" do
      expect {
        post :create, params: { patient: invalid_attributes }
      }.not_to change(Patient, :count)
    end
  end

  describe "DELETE #destroy" do
    it "deletes an existing patient" do
      patient = Patient.create!(valid_attributes)
      expect {
        delete :destroy, params: { id: patient.id }
      }.to change(Patient, :count).by(-1)
    end
  end
end
