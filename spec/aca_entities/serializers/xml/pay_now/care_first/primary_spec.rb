# frozen_string_literal: true

require "spec_helper"
require "aca_entities/pay_now/care_first"
require "aca_entities/serializers/xml/pay_now/care_first"

RSpec.describe AcaEntities::Serializers::Xml::PayNow::CareFirst::Primary do
  let(:member_name_params) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff",
      :person_middle_name => "Test",
      :person_full_name => "Jeff Thomas",
      :person_name_prefix_text => "Mr.",
      :person_name_suffix_text => "Sr.",
      :person_alternate_name => "Jeff" }
  end

  let(:payload_hash) do
    { :exchange_assigned_member_id => "1037294",
      :member_name => member_name_params }
  end

  let(:entity) do
    AcaEntities::PayNow::CareFirst::Primary.new(payload_hash)
  end

  subject do
    AcaEntities::Serializers::Xml::PayNow::CareFirst::Primary.domain_to_mapper(entity)
  end

  it "should generate an xml string" do
    expect(subject.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
  end
end
