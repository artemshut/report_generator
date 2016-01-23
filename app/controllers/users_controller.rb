class UsersController < ApplicationController
	before_action :authenticate_user!

	# FrontEnd validation needed
	def generate_report
		campaign_id = params[:campaign_id]
		if campaign_id.present?
			report_generator = ReportGeneratorService.new(params[:campaign_id])
			if report_generator.valid_campaign?
				report_generator.run
			else
				
			end
		end

	end

end
