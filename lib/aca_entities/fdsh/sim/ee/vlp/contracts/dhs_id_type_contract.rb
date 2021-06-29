# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp DhsIdType
          class DhsIdTypeContract < Dry::Validation::Contract
            params do
              optional(:i327DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I327DocumentId3TypeContract.params)
              optional(:i551DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I551DocumentId4TypeContract.params)
              optional(:i571DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I571DocumentId5TypeContract.params)
              optional(:i766DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I766DocumentId9TypeContract.params)
              optional(:certOfCitDocumentID).maybe(Fdsh::Sim::Ee::Vlp::CertOfCitDocumentId23TypeContract.params)
              optional(:natrOfCertDocumentID).maybe(Fdsh::Sim::Ee::Vlp::NatrOfCertDocumentId20TypeContract.params)
              optional(:macReadI551DocumentID).maybe(Fdsh::Sim::Ee::Vlp::MacReadI551DocumentId22TypeContract.params)
              optional(:tempI551DocumentID).maybe(Fdsh::Sim::Ee::Vlp::TempI551DocumentId21TypeContract.params)
              optional(:i94DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I94DocumentId2TypeContract.params)
              optional(:i94UnexpForeignPassportDocumentID).maybe(Fdsh::Sim::Ee::Vlp::I94UnexpForeignPassportDocumentId10TypeContract.params)
              optional(:unexpForeignPassportDocumentID).maybe(Fdsh::Sim::Ee::Vlp::UnexpForeignPassportDocumentId30TypeContract.params)
              optional(:i20DocumentID).maybe(Fdsh::Sim::Ee::Vlp::I20DocumentId26TypeContract.params)
              optional(:ds2019DocumentID).maybe(Fdsh::Sim::Ee::Vlp::Ds2019DocumentId27TypeContract.params)
              optional(:otherCase1DocumentID).maybe(Fdsh::Sim::Ee::Vlp::OtherCase1DocumentId1TypeContract.params)
              optional(:otherCase2DocumentID).maybe(Fdsh::Sim::Ee::Vlp::OtherCase2DocumentId1TypeContract.params)
            end
          end
        end
      end
    end
  end
end