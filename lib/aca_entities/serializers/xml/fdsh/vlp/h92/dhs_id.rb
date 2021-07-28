# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Vlp
          module H92
            # Happymapper implementation for the root object of an
            # Request.
            class DhsId
              include HappyMapper
              register_namespace 'vlp', 'http://vlp.ee.sim.dsh.cms.hhs.gov'

              tag 'DHSID'
              namespace 'vlp'

              has_one :I327DocumentID, I327DocumentId
              has_one :I551DocumentID, I551DocumentId
              has_one :I571DocumentID, I571DocumentId
              has_one :I766DocumentID, I766DocumentId
              has_one :CertOfCitDocumentID, CertOfCitDocumentId
              has_one :NatrOfCertDocumentID, NatrOfCertDocumentId
              has_one :MacReadI551DocumentID, MacReadI551DocumentId
              has_one :TempI551DocumentID, TempI551DocumentId
              has_one :I94DocumentID, I94DocumentId
              has_one :I94UnexpForeignPassportDocumentID, I94UnexpForeignPassportDocumentId
              has_one :UnexpForeignPassportDocumentID, UnexpForeignPassportDocumentId
              has_one :I20DocumentID, I20DocumentId
              has_one :DS2019DocumentID, Ds2019DocumentId
              has_one :OtherCase1DocumentID, OtherCase1DocumentId
              has_one :OtherCase2DocumentID, OtherCase2DocumentId

              # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
              def self.domain_to_mapper(dhs_id)
                obj = self.new
                obj.I327DocumentID = I327DocumentId.domain_to_mapper(dhs_id.I327DocumentID) if dhs_id.I327DocumentID.present?
                obj.I551DocumentID = I551DocumentId.domain_to_mapper(dhs_id.I551DocumentID) if dhs_id.I551DocumentID.present?
                obj.I571DocumentID = I571DocumentId.domain_to_mapper(dhs_id.I571DocumentID) if dhs_id.I571DocumentID.present?
                obj.I766DocumentID = I766DocumentId.domain_to_mapper(dhs_id.I766DocumentID) if dhs_id.I766DocumentID.present?
                obj.CertOfCitDocumentID = CertOfCitDocumentId.domain_to_mapper(dhs_id.CertOfCitDocumentID) if dhs_id.CertOfCitDocumentID.present?
                obj.NatrOfCertDocumentID = NatrOfCertDocumentId.domain_to_mapper(dhs_id.NatrOfCertDocumentID) if dhs_id.NatrOfCertDocumentID.present?
                if dhs_id.MacReadI551DocumentID.present?
                  obj.MacReadI551DocumentID = MacReadI551DocumentId.domain_to_mapper(dhs_id.MacReadI551DocumentID)
                end
                obj.TempI551DocumentID = TempI551DocumentId.domain_to_mapper(dhs_id.TempI551DocumentID) if dhs_id.TempI551DocumentID.present?
                obj.I94DocumentID = I94DocumentId.domain_to_mapper(dhs_id.I94DocumentID) if dhs_id.I94DocumentID.present?
                if dhs_id.I94UnexpForeignPassportDocumentID.present?
                  obj.I94UnexpForeignPassportDocumentID = I94UnexpForeignPassportDocumentId.domain_to_mapper(dhs_id.I94UnexpForeignPassportDocumentID)
                end
                if dhs_id.UnexpForeignPassportDocumentID.present?
                  obj.UnexpForeignPassportDocumentID = UnexpForeignPassportDocumentId.domain_to_mapper(dhs_id.UnexpForeignPassportDocumentID)
                end
                obj.I20DocumentID = I20DocumentId.domain_to_mapper(dhs_id.I20DocumentID) if dhs_id.I20DocumentID.present?
                obj.DS2019DocumentID = Ds2019DocumentId.domain_to_mapper(dhs_id.DS2019DocumentID) if dhs_id.DS2019DocumentID.present?
                obj.OtherCase1DocumentID = OtherCase1DocumentId.domain_to_mapper(dhs_id.OtherCase1DocumentID) if dhs_id.OtherCase1DocumentID.present?
                obj.OtherCase2DocumentID = OtherCase2DocumentId.domain_to_mapper(dhs_id.OtherCase2DocumentID) if dhs_id.OtherCase2DocumentID.present?

                obj
              end
              # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
            end
          end
        end
      end
    end
  end
end

