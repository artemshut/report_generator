class CreateGeneratedReports < ActiveRecord::Migration
  def change
    create_table :generated_reports do |t|
    	t.integer :user_id
    	t.integer :campaign_id

    	t.timestamps
    end
  end
end
