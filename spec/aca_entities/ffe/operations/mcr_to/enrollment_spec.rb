# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/ffe/operations/mcr_to/enrollment'
require 'aca_entities/ffe/transformers/mcr_to/enrollment'

RSpec.describe AcaEntities::FFE::Operations::McrTo::Enrollment do
  describe 'When a valid json file passed' do

    let(:params) { Pathname.pwd.join("spec/support/transform_example_payloads/enrollment.json") }

    before do
      @result = subject.call(JSON.parse(params.read))
      @request_payload_hash = @result.success.to_h
    end

    it 'should return success' do
      expect(@result).to be_success
    end

    it 'should return all the enrollment level attributes' do
      expect(@request_payload_hash).to have_key(:hbx_id)
      expect(@request_payload_hash).to have_key(:effective_on)
      expect(@request_payload_hash).to have_key(:market_place_kind)
      expect(@request_payload_hash).to have_key(:enrollment_period_kind)
      expect(@request_payload_hash).to have_key(:product_kind)
      expect(@request_payload_hash).to have_key(:product_reference)
      expect(@request_payload_hash).to have_key(:issuer_profile_reference)
      expect(@request_payload_hash).to have_key(:hbx_enrollment_members)
      expect(@request_payload_hash[:hbx_enrollment_members].one? { |mem| mem[:is_subscriber] == true }).to be_truthy
    end
  end
end
