class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy remove_photo]

  def remove_photo
    if @patient.photo.attached?
      @patient.photo.purge
      respond_to do |format|
        format.html { redirect_to edit_patient_path(@patient), notice: "Photo removed successfully." }
        format.turbo_stream
      end
    else
      redirect_to edit_patient_path(@patient), alert: "No photo to remove."
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end
end
