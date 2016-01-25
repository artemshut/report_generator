class CreateGeneratedReports < ActiveRecord::Migration
  def change
    create_table :generated_reports do |t|
    	t.integer :external_id
    	t.integer :user_id
    	t.integer :campaign_id
    	t.text :comment, limit: 160

    	t.timestamps
    end
  end
end
