# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/serializers/xml/fdsh/ssa'

RSpec.describe ::AcaEntities::Serializers::Xml::Fdsh::Ifsv::H9t::Operations::IfsvRequestToXml, dbclean: :after_each do

  let(:ifsv_verification_request_entity) do
    AcaEntities::Fdsh::Ifsv::H9t::Api::Request.call(
      ifsv_verification_request
    )
  end
  let(:ifsv_verification_request) do
    {
      :RequestID => "163061945",
      :IFSVApplicants =>
        [{ :Person =>
            { :PersonName =>
               { :PersonGivenName => "filing",
                 :PersonMiddleName => nil,
                 :PersonSurName => "jointly" },
              :PersonSSNIdentification => { :IdentificationID => "518124854" } },
           :TaxFilerCategoryCode => "PRIMARY" },
         { :Person =>
            { :PersonName =>
               { :PersonGivenName => "filing",
                 :PersonMiddleName => nil,
                 :PersonSurName => "spouse" },
              :PersonSSNIdentification => { :IdentificationID => "518124854" } },
           :TaxFilerCategoryCode => "SPOUSE" },
         { :Person =>
            { :PersonName =>
               { :PersonGivenName => "filing",
                 :PersonMiddleName => nil,
                 :PersonSurName => "child" },
              :PersonSSNIdentification => { :IdentificationID => "518124854" } },
           :TaxFilerCategoryCode => "DEPENDENT" }]
    }
  end

  subject do
    described_class.new.call(ifsv_verification_request_entity)
  end

  it "is successful" do
    expect(subject.success?).to be_truthy
  end
end
