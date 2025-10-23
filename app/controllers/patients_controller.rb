class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy remove_photo update_status]

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

    @patients = @patients.order(:order) # Optional: use saved order
  end

  def show; end

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

  def remove_photo
    if RemovePhoto.new(@patient).call
      respond_to do |format|
        format.html { redirect_to edit_patient_path(@patient), notice: "Photo removed successfully." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@patient, :photo_wrapper), partial: "patients/photo_wrapper", locals: { patient: @patient }) }
      end
    else
      redirect_to edit_patient_path(@patient), alert: "No photo to remove."
    end
  end

  # AJAX: Update treatment_status
  def update_status
    if @patient.update(treatment_status: params[:treatment_status])
      render json: { status: @patient.treatment_status }
    else
      render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # AJAX: Reorder patients
  def reorder
    params[:ordered_ids].each_with_index do |id, index|
      Patient.find(id).update(order: index + 1)
    end
    head :ok
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :age, :diagnosis, :admitted_on, :category, :critical_status, :treatment_time, :photo, :treatment_status)
  end
end
