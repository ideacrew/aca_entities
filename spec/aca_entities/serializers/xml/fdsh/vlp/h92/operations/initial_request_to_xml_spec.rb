# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::AcaEntities::Serializers::Xml::Fdsh::Vlp::H92::Operations::InitialRequestToXml, dbclean: :after_each do

  let(:initial_verification_request_entity) do
    AcaEntities::Fdsh::Vlp::H92::InitialVerificationRequest.call(initial_verification_request)
  end

  let(:initial_verification_request) do
    {
      :InitialVerificationRequestSets =>
      [{ :DHSID =>
         { :I94UnexpForeignPassportDocumentID =>
           { :I94Number => "02810190711",
             :VisaNumber => nil,
             :PassportNumber => "L1111111",
             :CountryOfIssuance => "IND",
             :SEVISID => nil,
             :DocExpirationDate => Date.new(2030, 12, 25) } },
         :FirstName => "Jimmy",
         :MiddleName => nil,
         :LastName => "Phan",
         :DateOfBirth => Date.new(1999, 12, 25),
         :AKA => nil,
         :FiveYearBarApplicabilityIndicator => true,
         :RequestSponsorDataIndicator => false,
         :RequestGrantDateIndicator => true,
         :SuspectedCounterfeitAlteredDocumentIndicator => false,
         :RequestCubanHaitianEntrantIndicator => false,
         :DocumentBinaryAttachment => nil,
         :RequesterCommentsForHub => nil,
         :CasePOCFullName => "DHS Tester",
         :CasePOCPhoneNumber => "5555555555",
         :CasePOCPhoneNumberExtension => "444" }]
    }
  end

  subject do
    described_class.new.call(initial_verification_request_entity)
  end

  it "is successful" do
    expect(subject.success?).to be_truthy
  end
end
