class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_customer

  def create
    transaction_params = {
      :amount => Product.find(params[:product_id]).price,
      :customer_id => current_user.braintree_customer_id,
    }
    if params[:token]
      transaction_params[:payment_method_token] = params[:token]
    else
      transaction_params[:credit_card] = {
        :number => params[:number],
        :cvv => params[:cvv],
        :expiration_month => params[:month],
        :expiration_year => params[:year],
      }
      transaction_params[:options] = {:store_in_vault => true}
    end

    result = Braintree::Transaction.sale(transaction_params)

    if result.success?
      # status will be authorized or submitted_for_settlement
      @message = "Transaction ID: #{result.transaction.id}, #{result.transaction.status}"
    else
      @message = "Message: #{result.message}"
      if result.transaction.nil?
        # validation errors prevented transaction from being created
        Rails.logger.debug result.errors
      else
        # status will be processor_declined, gateway_rejected, or failed
        @message += " ~ Transaction ID: #{result.transaction.id}, #{result.transaction.status}"
      end
    end

    render 'show'
  end
end
