


class PatientsController < ApplicationController

  #Used to load a patient for show,edit,update and delete CRUD
  before_action :set_patient, only: %i[show edit update destroy]


# 
def index
  @q = Patient.ransack(params[:q])
  @patients = @q.result(distinct: true)

  if params[:category_type].present? && params[:category_value].present?
    case params[:category_type]
    when "Age Group"
      @patients = @patients.where(category: params[:category_value])
    when "Critical Status"
      @patients = @patients.where(critical_status: params[:category_value])
    when "Treatment Time"
      @patients = @patients.where(treatment_time: params[:category_value])
    end
  end
end

  def select_category
  end





  def new
    @patient = Patient.new(
      category: params[:category],
      critical_status: params[:critical_status],
      treatment_time: params[:treatment_time]
    )
  end

  def create
    @patient = Patient.new(patient_params)

    if @patient.save
      redirect_to @patient, notice: "✅ Patient was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end
  def edit; end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy!
    redirect_to patients_path, alert: "Patient was successfully destroyed."
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name, :age, :diagnosis, :admitted_on,
      :category, :critical_status, :treatment_time
    )
  end
end
