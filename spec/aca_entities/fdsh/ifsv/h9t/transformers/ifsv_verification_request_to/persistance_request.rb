# frozen_string_literal: true

require 'spec_helper'
require 'aca_entities/magi_medicaid/libraries/iap_library'

RSpec.describe AcaEntities::Fdsh::Ifsv::H9t::Transformers::IfsvVerificationReqeustTo::PersistenceRequest do
  describe 'When a valid hash is passed' do

    let(:ifsv_request_payload) do
      { :RequestID => "163061945",
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
            :TaxFilerCategoryCode => "DEPENDENT" }] }
    end

    it 'should return transformed data' do
      result = described_class.transform(ifsv_request_payload)
      result[:ifsv_applicants].each do |ifsv_applicant|
        expect(ifsv_applicant).to have_key(:person)
        ifsv_applicant[:person].tap do |person|
          expect(person).to have_key(:person_name)
          expect(person).to have_key(:person_ssn_identification)
        end
        expect(ifsv_applicant).to have_key(:tax_filer_category_code)
      end
    end
  end
end