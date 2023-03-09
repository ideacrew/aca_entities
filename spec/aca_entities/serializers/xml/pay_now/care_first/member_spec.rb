# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/pay_now/care_first'
require 'aca_entities/serializers/xml/pay_now/care_first'

RSpec.describe AcaEntities::Serializers::Xml::PayNow::CareFirst::Member do
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
  let(:entity) do
    AcaEntities::PayNow::CareFirst::Member.new(member)
  end

  subject do
    AcaEntities::Serializers::Xml::PayNow::CareFirst::Member.domain_to_mapper(entity)
  end

  it "should generate and xml string" do
    expect(subject.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
  end
end