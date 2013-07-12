require 'spec_helper'

describe PaymentsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do

    before do
      @valid_params = {
        :amount => "1000.00",
        :credit_card => {
          :number => "5105105105105100",
          :expiration_month => "05",
          :expiration_year => "12"
        }
      }
    end

    describe "success" do

      before do
        xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<transaction>\n  <amount>1000.00</amount>\n  <credit-card>\n    <number>5105105105105100</number>\n    <expiration-month>05</expiration-month>\n    <expiration-year>12</expiration-year>\n  </credit-card>\n  <type>sale</type>\n</transaction>\n"
        url = "https://#{BRAINTREE['public_key']}:#{BRAINTREE['private_key']}@sandbox.braintreegateway.com/merchants/#{BRAINTREE['merchant_id']}/transactions"
        stub_request(:post, url).
                with(:body => xml).to_return(:status => 202, :body => "", :headers => {})
      end

      it "should make a request to the braintree API" do
        post 'create', @valid_params
      end

      it "should redirect to the transaction completed page" do
        post 'create', @valid_params
        response.should redirect_to payments_show_path
      end
    end
  end
end
