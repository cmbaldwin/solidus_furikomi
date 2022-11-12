# frozen_string_literal: true

FactoryBot.define do
  # Define your Spree extensions Factories within this file to enable applications, and other extensions to use and override them.
  #
  # Example adding this to your spec_helper will load these Factories for use:
  # require 'solidus_bank_transfer/factories'

  factory :bank_transfer_payment_method, class: Spree::PaymentMethod::Furikomi do
    name { 'Furikomi' }
    preferred_bank_name { 'みなと銀行' }
    preferred_branch_name { '赤穂支店' }
    preferred_account_type { '普通' }
    preferred_account_number { '1234567890' }
    preferred_account_holder_name { 'カブ）ドナルドダック' }
    description { 'Furikomi' }
    active { true }
  end
end
