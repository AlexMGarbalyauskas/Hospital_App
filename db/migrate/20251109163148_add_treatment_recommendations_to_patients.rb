class AddTreatmentRecommendationsToPatients < ActiveRecord::Migration[8.0]
  def change
    add_column :patients, :treatment_recommendations, :text
  end
end
