# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'
require 'aca_entities/magi_medicaid/shared_contexts/magi_medicaid_application_data'

RSpec.describe ::AcaEntities::MagiMedicaid::Operations::Mitc::GenerateRequestPayload do
  include_context 'setup magi_medicaid application with two applicants'

  let(:oos_address1) do
    { has_fixed_address: true,
      kind: 'home',
      address_1: '1234',
      address_3: 'person',
      city: 'test',
      county: '',
      county_name: '',
      state: 'VT',
      zip: '12345',
      country_name: 'USA',
      validation_status: 'ValidMatch',
      lives_outside_state_temporarily: false,
      start_on: Date.today.to_s,
      end_on: nil }
  end
  let(:oos_addresses) do
    [oos_address1]
  end

  before do
    iap_application[:applicants].last[:addresses] = oos_addresses
    @mm_application = ::AcaEntities::MagiMedicaid::Operations::InitializeApplication.new.call(iap_application).success
  end

  before do
    @result = subject.call(@mm_application)
    @request_payload_hash = @result.success
  end

  it 'should return success' do
    expect(@result).to be_success
  end

  it 'should set an applicant as a non-resident if they do not live in the application state' do
    person = @request_payload_hash[:People].detect { |h| h[:'Person ID'] == 96 }
    expect(person[:'Lives In State']).to eq 'N'
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
