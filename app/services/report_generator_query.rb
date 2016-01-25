class ReportGeneratorQuery
	include HTTParty
	attr_reader :campaign_id, :user_id

	def initialize campaign_id, user_id
		@campaign_id = campaign_id.to_i
		@user_id = user_id
	end

	# Stub method
	def valid_campaign?
		true
	end

	# Make queries to get specified data for chosen campaign
	def run
		my_credentials = {"user" => "test.api", 'password' => '5DRX-AF-gc4', 'client_id' => 'Test', 'client_secret' => 'xIpXeyMID9WC55en6Nuv0HOO5GNncHjeYW0t5yI5wpPIqEHV'}
		access_token = self.class.post('http://testcost.platform161.com/api/v2/access_tokens/', { query: my_credentials })['token']
		headers = {:headers => {'PFM161-API-AccessToken' => access_token}}
		advertiser_reports = self.class.post('https://testcost.platform161.com/api/v2/advertiser_reports/', headers )
		create_local_report advertiser_reports['id']
		campaign = self.class.get('https://testcost.platform161.com/api/v2/campaigns/' + campaign_id.to_s, headers )
		if advertiser_reports['results'] && advertiser_reports['results'].select { |campaign| campaign['campaign_id'] == campaign_id }.present?
			advertiser_report = advertiser_reports['results'].select { |campaign| campaign['campaign_id'] == campaign_id }
			ReportGeneratorCsvBuilder.new({advertiser_report: advertiser_report, campaign: campaign}).build
		else
			false
		end
	end

	private

	def create_local_report external_id
		GeneratedReport.create(user_id: user_id, external_id: external_id, campaign_id: campaign_id)
	end
end
