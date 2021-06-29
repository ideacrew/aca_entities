# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Sim
      module Ee
        module Vlp
          # Entity for Fdsh Vlp DhsIdType
          class DhsIdType < Dry::Struct

            attribute :i327DocumentID,                         Fdsh::Sim::Ee::Vlp::I327DocumentId3Type.meta(omittable: true)
            attribute :i551DocumentID,                         Fdsh::Sim::Ee::Vlp::I551DocumentId4Type.meta(omittable: true)
            attribute :i571DocumentID,                         Fdsh::Sim::Ee::Vlp::I571DocumentId5Type.meta(omittable: true)
            attribute :i766DocumentID,                         Fdsh::Sim::Ee::Vlp::I766DocumentId9Type.meta(omittable: true)
            attribute :certOfCitDocumentID,                    Fdsh::Sim::Ee::Vlp::CertOfCitDocumentId23Type.meta(omittable: true)
            attribute :natrOfCertDocumentID,                   Fdsh::Sim::Ee::Vlp::NatrOfCertDocumentId20Type.meta(omittable: true)
            attribute :macReadI551DocumentID,                  Fdsh::Sim::Ee::Vlp::MacReadI551DocumentId22Type.meta(omittable: true)
            attribute :tempI551DocumentID,                     Fdsh::Sim::Ee::Vlp::TempI551DocumentId21Type.meta(omittable: true)
            attribute :i94DocumentID,                          Fdsh::Sim::Ee::Vlp::I94DocumentId2Type.meta(omittable: true)
            attribute :i94UnexpForeignPassportDocumentID,      Fdsh::Sim::Ee::Vlp::I94UnexpForeignPassportDocumentId10Type.meta(omittable: true)
            attribute :unexpForeignPassportDocumentID,         Fdsh::Sim::Ee::Vlp::UnexpForeignPassportDocumentId30Type.meta(omittable: true)
            attribute :i20DocumentID,                          Fdsh::Sim::Ee::Vlp::I20DocumentId26Type.meta(omittable: true)
            attribute :ds2019DocumentID,                       Fdsh::Sim::Ee::Vlp::Ds2019DocumentId27Type.meta(omittable: true)
            attribute :otherCase1DocumentID,                   Fdsh::Sim::Ee::Vlp::OtherCase1DocumentId1Type.meta(omittable: true)
            attribute :otherCase2DocumentID,                   Fdsh::Sim::Ee::Vlp::OtherCase2DocumentId1Type.meta(omittable: true)
          end
        end
      end
    end
  end
end