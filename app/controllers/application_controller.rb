class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def set_customer
    if current_user.braintree_customer_id.nil?
      result = Braintree::Customer.create
      @customer = result.customer
      current_user.update_attributes! braintree_customer_id: @customer.id
    else
      @customer = Braintree::Customer.find(current_user.braintree_customer_id)
    end

    raise "No Braintree Customer found" unless @customer
  end
end
