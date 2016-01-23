require 'net/http'

class ReportGeneratorService
	include HTTParty
	attr_reader :campaign_id

	def initialize campaign_id
		@campaign_id = campaign_id
	end

	# Stub method
	def valid_campaign?
		true
	end

	def run
		my_credentials = {"user" => "test.api", 'password' => '5DRX-AF-gc4', 'client_id' => 'Test', 'client_secret' => 'xIpXeyMID9WC55en6Nuv0HOO5GNncHjeYW0t5yI5wpPIqEHV'}
		access_token = self.class.post('http://testcost.platform161.com/api/v2/access_tokens/', { query: my_credentials })['token']
		report_call = self.class.get('https://testcost.platform161.com/api/v2/campaigns' + campaign_id, :headers => {'PFM161-API-AccessToken' => access_token})
		binding.pry
	end
end
