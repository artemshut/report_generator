class UsersController < ApplicationController
	before_action :authenticate_user!

	# FrontEnd validation needed
	def generate_report
		campaign_id = params[:campaign_id]
		if campaign_id.present?
			report_generator = ReportGeneratorQuery.new(params[:campaign_id], current_user.id)
			@generated_report = report_generator.run
			render :show
		end

	end

end
