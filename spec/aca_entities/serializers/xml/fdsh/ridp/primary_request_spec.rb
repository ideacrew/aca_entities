# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ridp'

RSpec.describe AcaEntities::Serializers::Xml::Fdsh::Ridp::PrimaryRequest,
               "given a minimal Primary Response object" do

  let(:primary_request) do
    AcaEntities::Fdsh::Ridp::H139::PrimaryRequest.new({
                                                        Person: {
                                                          PersonName: {
                                                            PersonGivenName: "AGivenName",
                                                            PersonSurName: "A Sur Name"
                                                          }
                                                        },
                                                        CurrentAddress: {
                                                          LocationAddress: {
                                                            StructuredAddress: {
                                                              LocationStreet: {
                                                                StreetName: "Some Street"
                                                              },
                                                              LocationCityName: "Baltimore",
                                                              LocationStateUSPostalServiceCode: "MD",
                                                              LocationPostalCode: "21230"
                                                            }
                                                          }
                                                        }
                                                      })
  end

  subject do
    AcaEntities::Serializers::Xml::Fdsh::Ridp::Request.domain_to_mapper(
      primary_request,
      "primary_request"
    ).to_xml
  end

  it "creates a schema valid result" do
    validation_result = AcaEntities::Serializers::Xml::Fdsh::Ridp::Operations::ValidateRidpPayloadXml.new.call(subject)
    expect(validation_result.success?).to be_truthy
  end
end