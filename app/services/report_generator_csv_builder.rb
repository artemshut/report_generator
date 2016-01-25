class ReportGeneratorCsvBuilder

	attr_reader :advertiser_report, :campaign

	def initialize(options)
		@advertiser_report = options[:advertiser_report].first
		@campaign = options[:campaign]
	end

	# Build report with fields: Campaign Name, Start Date, End Date, Media Budget, Media Spent, Impressions, 
	#														Clicks, Ctr, Conversions, eCPM, eCPC, eCPA, Creative Name
	def build
	  {
	  	campaign_name: advertiser_report['campaign_name'].tr("_", " "),
	  	start_date: campaign['start_on'],
	  	end_date: campaign['end_on'],
	  	media_budget: campaign['media_budget'],
	  	media_spent: advertiser_report['total_campaign_cost'],
	  	impressions: advertiser_report['impressions'],
	  	clicks: advertiser_report['clicks'],
	  	ctr: advertiser_report['ctr'],
	  	conversions: advertiser_report['conversions'],
	  	ecpm: calc_ecpm_for(advertiser_report),
	  	ecpc: calc_ecpc_for(advertiser_report),
	  	ecpa: calc_ecpa_for(advertiser_report),
	  	creative_name: advertiser_report['creative_name']
	  	# spent:
	  }
	end

	private 

	def base_calc_ecp advertiser_report, field
		if advertiser_report['gross_revenues'] && advertiser_report[field] > 0
			yield
		else
			0
		end
	end

	def calc_ecpm_for advertiser_report
			base_calc_ecp(advertiser_report, 'impressions') do
				(advertiser_report['gross_revenues'] / advertiser_report['impressions']) * 100
			end
	end

	def calc_ecpc_for advertiser_report
		base_calc_ecp(advertiser_report, 'clicks') do
				(advertiser_report['gross_revenues'] / advertiser_report['clicks'])
			end
	end

	def calc_ecpa_for advertiser_report
		base_calc_ecp(advertiser_report, 'conversions') do
				(advertiser_report['gross_revenues'] / advertiser_report['conversions'])
			end
	end


end