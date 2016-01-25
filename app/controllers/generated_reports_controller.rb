class GeneratedReportsController < ApplicationController
	before_action :authenticate_user!

	def index
		@generated_reports = current_user.generated_reports
	end

	def update
		@generated_report = GeneratedReport.find(params[:id])
		@generated_report.update_attributes!(generated_reports_params)
		redirect_to user_generated_reports_path(current_user.id)
	end

	private 

	def generated_reports_params
		params.require(:generated_report).permit(:comment)
	end
end