class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  def index
    @patients = Patient.all

    if params[:query].present?
      query = params[:query].downcase
      @patients = @patients.where(
        "LOWER(name) LIKE ? OR LOWER(diagnosis) LIKE ? OR CAST(age AS TEXT) LIKE ? OR LOWER(critical_status) LIKE ? OR LOWER(treatment_status) LIKE ? OR LOWER(gender) LIKE ?",
        "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
      )
    end

    if params[:category_type].present? && params[:category_value].present?
      case params[:category_type]
      when "Age Group"
        @patients = @patients.where(age_group: params[:category_value])
      when "Critical Status"
        @patients = @patients.where(critical_status: params[:category_value])
      when "Treatment Time"
        if params[:category_value] == "Scheduled"
          @patients = @patients.where.not(treatment_date: nil)
        elsif params[:category_value] == "Routine"
          @patients = @patients.where(treatment_date: nil)
        end
      end
    end
  end

  def show 
   @patient = Patient.find(params[:id])

  # fetch vaccine data
  service = CovidVaccineDataService.new
  @vaccine_map = service.fetch_vaccine_data
  end

  def new; @patient = Patient.new; end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to @patient, notice: "Patient created successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient deleted successfully"
  end

  # Mass delete
  def delete_multiple
    if params[:patient_ids].present?
      Patient.where(id: params[:patient_ids]).destroy_all
      redirect_to patients_path, notice: "Selected patients were deleted successfully."
    else
      redirect_to patients_path, alert: "No patients selected for deletion."
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name, :age, :diagnosis, :critical_status,
      :treatment_status, :treatment_date, :treatment_reason,
      :date_of_death, :reason_of_death,
      :gender, :vaccinated, :profile_pic
    )
  end
end
