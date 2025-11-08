class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all
    if params[:query].present?
      q = "%#{params[:query]}%"
      @patients = @patients.where(
        "name ILIKE :q OR CAST(age AS TEXT) ILIKE :q OR diagnosis ILIKE :q OR critical_status ILIKE :q OR treatment_status ILIKE :q OR living_status ILIKE :q",
        q: q
      )
    end
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to patients_path, notice: "Patient created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to patient_path(@patient), notice: "Patient updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient deleted."
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name,
      :age,
      :diagnosis,
      :critical_status,
      :treatment_status,
      :living_status,
      :profile_pic
    )
  end
end
