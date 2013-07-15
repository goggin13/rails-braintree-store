class PaymentsController < ApplicationController
  def show
  end

  def new
  end

  def create
    result = Braintree::Transaction.sale(
      :amount => "1000.00",
      :credit_card => {
        :number => "5105105105105100",
        :expiration_month => "05",
        :expiration_year => "12"
      }
    )

    if result.success?
        puts "Transaction ID: #{result.transaction.id}"
        # status will be authorized or submitted_for_settlement
        puts "Transaction Status: #{result.transaction.status}"
    else
      puts "Message: #{result.message}"
      if result.transaction.nil?
        # validation errors prevented transaction from being created
        p result.errors
      else
        puts "Transaction ID: #{result.transaction.id}"
        # status will be processor_declined, gateway_rejected, or failed
        puts "Transaction Status: #{result.transaction.status}"
      end
    end
    redirect_to payments_show_path
  end
end
