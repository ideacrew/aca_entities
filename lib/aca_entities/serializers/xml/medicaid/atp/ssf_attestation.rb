# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An attestation a signer makes when submitting an application.
          class SsfAttestation
            include HappyMapper

            tag 'SSFAttestation'
            namespace 'hix-ee'

            # True if a signer attests that they agree to cooperate with agencies that collect medical support information from absent parents;
            # false otherwise.
            element :collections_agreement_indicator, Boolean, tag: 'SSFAttestationCollectionsAgreementIndicator'

            # True if a signer attests that they are aware of their obligations as a Medicaid applicant; false otherwise.
            element :medicaid_obligations_indicator, Boolean, tag: 'SSFAttestationMedicaidObligationsIndicator'

            # True if a signer attests that the information provided is truthful; false otherwise.
            element :non_perjury_indicator, Boolean, tag: 'SSFAttestationNonPerjuryIndicator'

            # True if a signer attests that they are not currently incarcerated; false otherwise.
            has_many :not_incarcerated_indicators, NotIncarceratedIndicator

            # True if a signer attests that they understand how their information will be used; false otherwise
            element :privacy_agreement_indicator, Boolean, tag: 'SSFAttestationPrivacyAgreementIndicator'

            # True if a signer attests that they are not currently incarcerated but pending disposition of a criminal charge; false otherwise.
            element :pending_charges_indicator, Boolean, tag: 'SSFAttestationPendingChargesIndicator'

            # True if a signer attests that they agree to inform the exchange if information on the application changes; false otherwise.
            element :information_changes_indicator, Boolean, tag: 'SSFAttestationInformationChangesIndicator'

            # True if a signer attests that they agree to the terms of the insurance application; false otherwise.
            element :application_terms_indicator, Boolean, tag: 'SSFAttestationApplicationTermsIndicator'

            def self.domain_to_mapper(attestation)
              mapper = self.new
              mapper.collections_agreement_indicator = attestation.collections_agreement_indicator
              mapper.medicaid_obligations_indicator = attestation.medicaid_obligations_indicator
              mapper.non_perjury_indicator = attestation.non_perjury_indicator
              mapper.not_incarcerated_indicators = attestation.not_incarcerated_indicators.map do |i|
                NotIncarceratedIndicator.domain_to_mapper(i)
              end
              mapper.privacy_agreement_indicator = attestation.privacy_agreement_indicator
              mapper.pending_charges_indicator = attestation.pending_charges_indicator
              mapper.information_changes_indicator = attestation.information_changes_indicator
              mapper.application_terms_indicator = attestation.application_terms_indicator
              mapper
            end

            def to_hash
              {
                collections_agreement_indicator: collections_agreement_indicator,
                medicaid_obligations_indicator: medicaid_obligations_indicator,
                non_perjury_indicator: non_perjury_indicator,
                not_incarcerated_indicators: not_incarcerated_indicators.map(&:to_hash).map { |x| x[:value] }.all?(true),
                privacy_agreement_indicator: privacy_agreement_indicator,
                pending_charges_indicator: pending_charges_indicator,
                information_changes_indicator: information_changes_indicator,
                application_terms_indicator: application_terms_indicator
              }
            end
          end
        end
      end
    end
  end
end