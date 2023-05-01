# frozen_string_literal: true

require "spec_helper"
require "aca_entities/pay_now/care_first"
require "aca_entities/serializers/xml/pay_now/care_first"

RSpec.describe AcaEntities::Serializers::Xml::PayNow::CareFirst::MemberName do
  let(:member_name) do
    { :person_surname => "Thomas",
      :person_given_name => "Jeff",
      :person_middle_name => "Test",
      :person_full_name => "Jeff Thomas",
      :person_name_prefix_text => "Mr.",
      :person_name_suffix_text => "Sr.",
      :person_alternate_name => "Jeff" }
  end
  let(:entity) do
    AcaEntities::PayNow::CareFirst::MemberName.new(member_name)
  end

  subject do
    AcaEntities::Serializers::Xml::PayNow::CareFirst::MemberName.domain_to_mapper(entity)
  end

  it "should generate and xml string" do
    expect(subject.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
  end
end
