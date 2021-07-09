# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'
require 'pry'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::SecondaryRequest,
               "given a minimal Primary Response object" do

  let(:secondary_request) do
    AcaEntities::Fdsh::Ridp::H139::SecondaryRequest.new(
      {
        SessionIdentification: '123456789',
        VerificationAnswerSet: {
          VerificationAnswers: [
            {
              VerificatonAnswer: 0o1,
              VerificationQuestionNumber: 0o1
            },
            {
              VerificatonAnswer: 0o4,
              VerificationQuestionNumber: 0o2
            },
            {
              VerificatonAnswer: 0o2,
              VerificationQuestionNumber: 0o3
            }
          ]
        }
      }
    )
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Ridp::Request.domain_to_mapper(
      secondary_request,
      "secondary_request"
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end
