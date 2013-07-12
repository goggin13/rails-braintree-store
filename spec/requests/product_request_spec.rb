require 'spec_helper'

describe 'Product Requests' do

  describe "a product page" do

    before do
     @product = FactoryGirl.create(:product)
    end

    describe "purchases" do

      it "should should have a link to purchase" do
        visit product_path(@product)
        page.should have_button "Purchase"
        page.should have_field "Credit Card Number"
        page.should have_field "CVV"
        page.should have_field "Expiration Date"
      end

      describe "success" do
        it "should take you to the payment page" do
          visit product_path(@product)
          click_link "Purchase"
          page.should have_content "Transaction Completed"
        end
      end
    end
  end
end
