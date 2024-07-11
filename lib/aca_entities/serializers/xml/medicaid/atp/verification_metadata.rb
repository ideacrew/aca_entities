# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A Metadata about any object, provided by a verifying authority.
          class VerificationMetadata
            include HappyMapper

            tag 'VerificationMetadata'
            namespace 'hix-core'

            # A verification of an address.
            element :address_verification_code, String, tag: 'AddressVerificationCode'

            # A verification of a document, established by the Department of Homeland Security (DHS)
            # Systematic Alien Verification for Entitlements (SAVE) program.
            element :dhs_g845_verification_code, String, tag: 'DHS-G845VerificationCode'

            # A verification of information about a person, provided by the Department of Homeland Security (DHS)
            # Systematic Alien Verification for Entitlements (SAVE) verification program.
            element :dhs_save_verification_code, String, tag: 'DHS-SAVEVerificationCode'

            # A verification of information, established by the Federally Facilitated Exchange verification process.
            # (The process starts in the pending (P) state, followed by verified (Y) or inconsistent (I). If resolved, I transitions to verified (Y);
            # if not resolved, I transitions to not verified (N). Additional states exist to capture delays in the verification process.)
            element :ffe_verification_code, String, tag: 'FFEVerificationCode'

            # A name of a verification authority.
            element :verification_authority_name, String, tag: 'VerificationAuthorityName'

            # A trusted data source, as specified by the Centers for Medicare &amp; Medicaid Services.
            element :verification_authority_alpha_code, String, tag: 'VerificationAuthorityTDS-FEPS-AlphaCode'

            # A date a verification was performed.
            has_one :verification_date, VerificationDate

            # An information exchange system that requested a verification.
            has_one :verification_requesting_system, VerificationRequestingSystem

            # True if the information has been verified as accurate; false if the information has been rejected as inaccurate.
            element :verification_indicator, Boolean, tag: 'VerificationIndicator'

            # An identification for a verification.
            attribute :id, String, namespace: "niem-s"

            # A comment from a verifier.
            element :verification_description_text, String, tag: 'VerificationDescriptionText'

            # A justification of an inconsistency identified during verification (regardless of the acceptability of the justification).
            element :verification_inconsistency_text, String, tag: 'VerificationInconsistencyJustificationText'

            # True if an acceptable justification for an inconsistency has been provided; false otherwise.<
            element :verification_inconsistency_indicator, Boolean, tag: 'VerificationInconsistencyAcceptableIndicator'

            has_one :verification_status, VerificationStatus

            has_many :verification_category_codes, String, tag: 'VerificationCategoryCode'

            element :response_code, String, tag: 'ResponseCode'

            def self.domain_to_mapper(metadata)
              mapper = self.new
              mapper.address_verification_code = metadata.address_verification_code
              mapper.dhs_g845_verification_code = metadata.dhs_g845_verification_code
              mapper.dhs_save_verification_code = metadata.dhs_save_verification_code
              mapper.ffe_verification_code = metadata.ffe_verification_code
              mapper.verification_authority_name = metadata.verification_authority_name
              mapper.verification_authority_alpha_code = metadata.verification_authority_alpha_code
              mapper.verification_indicator = metadata.verification_indicator
              mapper.id = metadata.id
              mapper.verification_description_text = metadata.verification_description_text
              mapper.verification_inconsistency_text = metadata.verification_inconsistency_text
              mapper.verification_inconsistency_indicator = metadata.verification_inconsistency_indicator
              mapper.response_code = metadata.response_code
              mapper.verification_date = VerificationDate.domain_to_mapper(metadata.verification_date)
              mapper.verification_requesting_system = VerificationRequestingSystem.domain_to_mapper(metadata.verification_requesting_system)
              if metadata.verification_category_codes.present?
                mapper.verification_category_codes = metadata.verification_category_codes.map {|vc| VerificationCategoryCode.domain_to_mapper(vc)}
              end
              mapper.verification_status = VerificationStatus.domain_to_mapper(metadata.verification_status)
              mapper
            end

            def to_hash
              {
                address_verification_code: address_verification_code,
                dhs_g845_verification_code: dhs_g845_verification_code,
                dhs_save_verification_code: dhs_save_verification_code,
                ffe_verification_code: ffe_verification_code,
                verification_authority_name: verification_authority_name,
                verification_authority_alpha_code: verification_authority_alpha_code,
                verification_indicator: verification_indicator,
                verification_id: verification_id,
                verification_description_text: verification_description_text,
                verification_inconsistency_text: verification_inconsistency_text,
                verification_inconsistency_indicator: verification_inconsistency_indicator,
                response_code: response_code,
                verification_date: verification_date.to_hash,
                verification_requesting_system: verification_requesting_system.to_hash,
                verification_status: verification_status&.to_hash
              }
            end
          end
        end
      end
    end
  end
end