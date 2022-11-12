# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Spree::PaymentMethod::Furikomi, type: :model do
  let(:order) { Spree::Order.new }
  let(:payment_method) { described_class.create!(name: 'Furikomi', active: true) }
  let(:payment) do
    Spree::Payment.new(amount: 0.0, order: order, payment_method: payment_method)
  end

  before do
    payment_method.save!
  end

  describe 'preferences' do
    before do
      payment_method.update!(
        preferred_bank_name: 'みなと銀行',
        preferred_branch_name: '赤穂支店',
        preferred_account_type: '普通',
        preferred_account_number: '1234567890',
        preferred_account_holder_name: 'カブ）ドナルドダック'
      )
    end

    it 'saves the preferences' do
      aggregate_failures do
        expect(payment_method.preferred_bank_name).to eq('みなと銀行')
        expect(payment_method.preferred_branch_name).to eq('赤穂支店')
        expect(payment_method.preferred_account_type).to eq('普通')
        expect(payment_method.preferred_account_number).to eq('1234567890')
        expect(payment_method.preferred_account_holder_name).to eq('カブ）ドナルドダック')
      end
    end
  end

  describe '#actions' do
    it 'returns actions' do
      expect(payment_method.actions).to eq(%w[capture void credit])
    end
  end

  describe '#can_capture?' do
    context 'when payment state is checkout' do
      before do
        payment.update!(state: 'checkout')
      end

      it 'returns true' do
        expect(payment_method.can_capture?(payment)).to be true
      end
    end

    context 'when payment state is pending' do
      before do
        payment.update!(state: 'pending')
      end

      it 'returns true' do
        expect(payment_method.can_capture?(payment)).to be true
      end
    end

    context 'when payment state is not pending or checkout' do
      before do
        payment.update!(state: 'void')
      end

      it 'returns false' do
        expect(payment_method.can_capture?(payment)).to be false
      end
    end
  end

  describe '#can_void?' do
    context 'when payment state is not void' do
      before do
        payment.update!(state: 'pending')
      end

      it 'returns true' do
        expect(payment_method.can_void?(payment)).to be true
      end
    end

    context 'when payment state is void' do
      before do
        payment.update!(state: 'void')
      end

      it 'returns false' do
        expect(payment_method.can_void?(payment)).to be false
      end
    end
  end

  describe '#capture' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.capture
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.capture).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#void' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.void
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.void).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#try_void' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.try_void
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.try_void).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#credit' do
    it 'creates a new active merchant billing response' do
      allow(ActiveMerchant::Billing::Response).to receive(:new)
      payment_method.credit
      expect(ActiveMerchant::Billing::Response).to have_received(:new).with(true, '', {}, {})
    end

    it 'returns active merchant billing response' do
      expect(payment_method.credit).to be_a(ActiveMerchant::Billing::Response)
    end
  end

  describe '#source_required?' do
    it 'returns false' do
      expect(payment_method.source_required?).to be false
    end
  end
end
