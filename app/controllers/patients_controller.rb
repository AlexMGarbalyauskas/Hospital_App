# app/controllers/patients_controller.rb


# handles all the CRUD (Create, Read, Update, Delete) 
# operations, plus some extra features like search, 
# filtering, and mass deletion


#main class
# sets up a controller to manage patient records
class PatientsController < ApplicationController

  # sets patient before certain actions
  before_action :set_patient, only: [:show, :edit, :update, :destroy]









  #1
  # GET /patients
  def index


    # fetch all patients
    @patients = Patient.all



#1.1 
    # search functionality
    if params[:query].present?

      # downcase the search query for case-insensitive matching
      query = params[:query].downcase

      # filter patients based on multiple attributes
      @patients = @patients.where(
        "LOWER(name) LIKE ? OR LOWER(diagnosis) LIKE ? OR CAST(age AS TEXT) LIKE ? OR LOWER(critical_status) LIKE ? OR LOWER(treatment_status) LIKE ? OR LOWER(gender) LIKE ?",
        "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%"
      )
    end # end search
#1.1 end 





#1.2 
    # filtering functionality
    if params[:category_type].present? && params[:category_value].present?
      case params[:category_type]
      when "Age Group"
        @patients = @patients.where(age_group: params[:category_value])
      
      # when filtering by critical status
      when "Critical Status"
        @patients = @patients.where(critical_status: params[:category_value])
      
      # when filtering by treatment status
      when "Treatment Time"

        # checks if filtering by scheduled or routine treatment
        if params[:category_value] == "Scheduled"
          
          @patients = @patients.where.not(treatment_date: nil)
        elsif params[:category_value] == "Routine"
          
          @patients = @patients.where(treatment_date: nil)
        end
      end
    end # end filtering
  #1.2 end 


  end # end index action
  #1 end 










#2
  # show single patient
  def show
    @patient = Patient.find(params[:id])

    # fetch vaccine data
    service = CovidVaccineDataService.new

    # retrieve vaccine data
    @vaccine_map = service.fetch_vaccine_data
  end
#2 end








#3 
  # new patient form
  def new
    @patient = Patient.new
  end
#3 end









#4
  # create new patient
  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to @patient, notice: "Patient created successfully"
    else
      render :new
    end
  end
#4 end 






#5
  # edit existing patient
  def edit; 
  end
#5 end 





#6 
  # update existing patient
  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Patient updated successfully"
    else
      render :edit
    end
  end
#6 end






#7
  # delete single patient
  def destroy
    @patient.destroy
    redirect_to patients_path, notice: "Patient deleted successfully"
  end
#7 end







#8 
  # mass delete patients
  def delete_multiple
    if params[:patient_ids].present?
      Patient.where(id: params[:patient_ids]).destroy_all
      redirect_to patients_path, notice: "Selected patients were deleted successfully."
    else
      redirect_to patients_path, alert: "No patients selected for deletion."
    end
  end
#8 end





  private

#9
  # set patient before certain actions
  def set_patient
    @patient = Patient.find(params[:id])
  end
#9 end






#10 
  # strong parameters for patient
  # lists allowed attributes for mass assignment
  def patient_params

    # all permitted patient attributes in database
    params.require(:patient).permit(
      :name, :age, :diagnosis, :critical_status,
      :treatment_status, :treatment_date, :treatment_reason,
      :date_of_death, :reason_of_death,
      :gender, :vaccinated, :profile_pic
    )
  end
#10 end 






end # end of PatientsController
