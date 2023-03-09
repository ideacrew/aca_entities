# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'
require 'aca_entities/serializers/xml/pay_now/care_first'

RSpec.describe AcaEntities::Serializers::Xml::PayNow::CareFirst::PayNowTransferPayload do
  let(:member_name) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff" }
  end
  let(:member) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name,
      :birth_date => "19740601",
      :sex => "M",
      :ssn => "999121212",
      :relationship => "18",
      :is_subscriber => true }
  end
  let(:payload_hash) do
    { :coverage_kind => "urn:openhbx:terms:v1:qhp_benefit_coverage#health",
      :members => [member] }
  end
  let(:entity) do
    AcaEntities::PayNow::CareFirst::PayNowTransferPayload.new(payload_hash)
  end

  subject do
    AcaEntities::Serializers::Xml::PayNow::CareFirst::PayNowTransferPayload.domain_to_mapper(entity)
  end

  it 'should generate and xml string' do
    expect(subject.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
  end

  it 'creates a schema valid result' do
    # add validation operation and get result here
    # expect(validation_result.success?).to be_truthy
  end
end
