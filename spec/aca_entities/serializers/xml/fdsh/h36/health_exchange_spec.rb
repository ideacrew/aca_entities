# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/h36'
require 'aca_entities/fdsh/h36/irs_household_coverage_shared_context'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::H36::HealthExchange, dbclean: :after_each do
  include_context('irs_group_coverage_shared_context')

  let(:required_params) do
    {
      SubmissionYr: Date.today.year.to_s,
      SubmissionMonthNum: Date.today.month.to_s,
      ApplicableCoverageYr: Date.today.year.to_s,
      IndividualExchange: individual_exchange
    }
  end

  let(:health_exchange_request) do
    AcaEntities::Fdsh::H36::HealthExchange.new(required_params)
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::H36::HealthExchange.domain_to_mapper(
      health_exchange_request
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::H36::Operations::ValidateH36RequestPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
