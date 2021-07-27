# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Vlp
      module H92
        # Entity for Fdsh Vlp DhsId
        class DhsId < Dry::Struct

          attribute :I327DocumentID,                         Fdsh::Vlp::H92::I327DocumentId.optional.meta(omittable: true)
          attribute :I551DocumentID,                         Fdsh::Vlp::H92::I551DocumentId.optional.meta(omittable: true)
          attribute :I571DocumentID,                         Fdsh::Vlp::H92::I571DocumentId.optional.meta(omittable: true)
          attribute :I766DocumentID,                         Fdsh::Vlp::H92::I766DocumentId.optional.meta(omittable: true)
          attribute :CertOfCitDocumentID,                    Fdsh::Vlp::H92::CertOfCitDocumentId.optional.meta(omittable: true)
          attribute :NatrOfCertDocumentID,                   Fdsh::Vlp::H92::NatrOfCertDocumentId.optional.meta(omittable: true)
          attribute :MacReadI551DocumentID,                  Fdsh::Vlp::H92::MacReadI551DocumentId.optional.meta(omittable: true)
          attribute :TempI551DocumentID,                     Fdsh::Vlp::H92::TempI551DocumentId.optional.meta(omittable: true)
          attribute :I94DocumentID,                          Fdsh::Vlp::H92::I94DocumentId.optional.meta(omittable: true)
          attribute :I94UnexpForeignPassportDocumentID,      Fdsh::Vlp::H92::I94UnexpForeignPassportDocumentId.optional.meta(omittable: true)
          attribute :UnexpForeignPassportDocumentID,         Fdsh::Vlp::H92::UnexpForeignPassportDocumentId.optional.meta(omittable: true)
          attribute :I20DocumentID,                          Fdsh::Vlp::H92::I20DocumentId.optional.meta(omittable: true)
          attribute :DS2019DocumentID,                       Fdsh::Vlp::H92::Ds2019DocumentId.optional.meta(omittable: true)
          attribute :OtherCase1DocumentID,                   Fdsh::Vlp::H92::OtherCase1DocumentId.optional.meta(omittable: true)
          attribute :OtherCase2DocumentID,                   Fdsh::Vlp::H92::OtherCase2DocumentId.optional.meta(omittable: true)

        end
      end
    end
  end
end
