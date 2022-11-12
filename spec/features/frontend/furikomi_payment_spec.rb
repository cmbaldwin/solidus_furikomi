# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Checkout - Payment with furikomi', type: :feature, js: true do
  let(:payment_method) do
    create(:furikomi_payment_method,
           bank_name: 'みなと銀行',
           branch_name: '赤穂支店',
           account_type: '普通',
           account_number: '1234567890',
           account_holder_name: 'カブ）ドナルドダック')
  end

  let(:user) { create(:user_with_addresses) }
  let(:order) { create(:order_with_line_items) }

  before do
    payment_method
    order.associate_user!(user)

    # rubocop:disable RSpec/AnyInstance
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(current_order: order)
    allow_any_instance_of(Spree::CheckoutController).to receive_messages(try_spree_current_user: user)
    allow_any_instance_of(Spree::OrdersController).to receive_messages(try_spree_current_user: user)
    # rubocop:enable RSpec/AnyInstance

    visit spree.checkout_state_path(:payment)
  end

  it 'shows the furikomi payment' do
    expect(page).to have_content('みなと銀行')
    expect(page).to have_content('赤穂支店')
    expect(page).to have_content('普通')
    expect(page).to have_content('1234567890')
    expect(page).to have_content('カブ）ドナルドダック')
  end
end
