class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @patients = Patient.all

    # Free-text search (SQLite-compatible case-insensitive)
    if params[:query].present?
      q = "%#{params[:query].downcase}%"
      @patients = @patients.where(
        "LOWER(name) LIKE :q OR CAST(age AS TEXT) LIKE :q OR LOWER(diagnosis) LIKE :q OR LOWER(critical_status) LIKE :q OR LOWER(treatment_status) LIKE :q OR LOWER(living_status) LIKE :q",
        q: q
      )
    end

    # Category filter
    if params[:category_type].present? && params[:category_value].present?
      case params[:category_type]
      when "Age Group"
        @patients = @patients.select { |p| p.age_group == params[:category_value] }
      when "Critical Status"
        @patients = @patients.where(critical_status: params[:category_value])
      when "Treatment Time"
        @patients = @patients.where(treatment_status: params[:category_value])
      end
    end
  end

  def show; end

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

  def edit; end

  def update
    if @patient.update(patient_params)
      redirect_to patient_path(@patient), notice: "Patient updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @patient.destroy
      respond_to do |format|
        format.html { redirect_to patients_path, notice: "Patient deleted successfully." }
        format.turbo_stream { render turbo_stream: turbo_stream.remove(dom_id(@patient)) }
      end
    else
      redirect_to patients_path, alert: "Unable to delete patient."
    end
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
