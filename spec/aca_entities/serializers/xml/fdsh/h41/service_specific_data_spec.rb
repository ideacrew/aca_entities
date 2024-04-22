# frozen_string_literal: true

require "spec_helper"
require "aca_entities/fdsh/h41/service_specific_data"
require "aca_entities/serializers/xml/fdsh/h41/service_specific_data"

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::H41::ServiceSpecificData do
  let(:params) do
    {
      ReportPeriod: {
        YearMonth: '2023-01'
      },
      OriginalBatchID: '123456'
    }
  end

  let(:entity) do
    AcaEntities::Fdsh::H41::ServiceSpecificData.new(params)
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::H41::ServiceSpecificData.domain_to_mapper(entity)
  end

  it "should generate an xml string" do
    expect(subject.to_xml.split("\n").first).to eq '<?xml version="1.0"?>'
    expect(subject.to_xml).to include('OriginalBatchID')
  end
end
