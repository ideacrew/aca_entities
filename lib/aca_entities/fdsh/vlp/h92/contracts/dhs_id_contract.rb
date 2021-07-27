# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Contract for Fdsh Vlp DhsId
        class DhsIdContract < Dry::Validation::Contract
          params do
            optional(:I327DocumentID).maybe(Fdsh::Vlp::H92::I327DocumentIdContract.params)
            optional(:I551DocumentID).maybe(Fdsh::Vlp::H92::I551DocumentIdContract.params)
            optional(:I571DocumentID).maybe(Fdsh::Vlp::H92::I571DocumentIdContract.params)
            optional(:I766DocumentID).maybe(Fdsh::Vlp::H92::I766DocumentIdContract.params)
            optional(:CertOfCitDocumentID).maybe(Fdsh::Vlp::H92::CertOfCitDocumentIdContract.params)
            optional(:NatrOfCertDocumentID).maybe(Fdsh::Vlp::H92::NatrOfCertDocumentIdContract.params)
            optional(:MacReadI551DocumentID).maybe(Fdsh::Vlp::H92::MacReadI551DocumentIdContract.params)
            optional(:TempI551DocumentID).maybe(Fdsh::Vlp::H92::TempI551DocumentIdContract.params)
            optional(:I94DocumentID).maybe(Fdsh::Vlp::H92::I94DocumentIdContract.params)
            optional(:I94UnexpForeignPassportDocumentID).maybe(Fdsh::Vlp::H92::I94UnexpForeignPassportDocumentIdContract.params)
            optional(:UnexpForeignPassportDocumentID).maybe(Fdsh::Vlp::H92::UnexpForeignPassportDocumentIdContract.params)
            optional(:I20DocumentID).maybe(Fdsh::Vlp::H92::I20DocumentIdContract.params)
            optional(:DS2019DocumentID).maybe(Fdsh::Vlp::H92::Ds2019DocumentIdContract.params)
            optional(:OtherCase1DocumentID).maybe(Fdsh::Vlp::H92::OtherCase1DocumentIdContract.params)
            optional(:OtherCase2DocumentID).maybe(Fdsh::Vlp::H92::OtherCase2DocumentIdContract.params)
          end
        end
      end
    end
  end
end