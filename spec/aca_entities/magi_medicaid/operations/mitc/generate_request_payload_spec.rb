# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/shared_contexts/magi_medicaid_application_data'

RSpec.describe ::AcaEntities::MagiMedicaid::Operations::Mitc::GenerateRequestPayload do
  include_context 'setup magi_medicaid application with two applicants'

  before do
    @mm_application = ::AcaEntities::MagiMedicaid::Operations::InitializeApplication.new.call(iap_application).success
  end

  before do
    @result = subject.call(@mm_application)
    @request_payload_hash = JSON.parse(@result.success, symbolize_names: true)
  end

  it 'should return success' do
    expect(@result).to be_success
  end

  it 'should return all the application level attributes' do
    expect(@request_payload_hash).to have_key(:State)
    expect(@request_payload_hash).to have_key(:'Application Year')
    expect(@request_payload_hash).to have_key(:Name)
    expect(@request_payload_hash[:Name]).to eq(iap_application[:hbx_id])
    expect(@request_payload_hash).to have_key(:People)
    expect(@request_payload_hash).to have_key(:'Physical Households')
    expect(@request_payload_hash).to have_key(:'Tax Returns')
  end
end
