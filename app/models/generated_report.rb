class GeneratedReport < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :user_id, :external_id
end
