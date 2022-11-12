# frozen_string_literal: true

module Spree
  class PaymentMethod::Furikomi < PaymentMethod
    preference :bank_name, :string
    preference :branch_name, :string
    preference :account_type, :string
    preference :account_number, :string
    preference :account_holder_name, :string

    def actions
      %w[capture void credit]
    end

    # Indicates whether its possible to capture the payment
    def can_capture?(payment)
      %w[checkout pending].include?(payment.state)
    end

    # Indicates whether its possible to void the payment.
    def can_void?(payment)
      payment.state != 'void'
    end

    def capture(*)
      simulated_successful_billing_response
    end

    def void(*)
      simulated_successful_billing_response
    end
    alias try_void void

    def credit(*)
      simulated_successful_billing_response
    end

    def source_required?
      false
    end

    private

    def simulated_successful_billing_response
      ActiveMerchant::Billing::Response.new(true, '', {}, {})
    end
  end
end
