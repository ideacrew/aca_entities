# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for IAP Application.
    class Application < Dry::Struct
      attribute :family_reference, AcaEntities::Families::FamilyReference.meta(omittable: false)

      # The year to which the application is applicable for
      # Year that is used on which to determine APTC Eligibility
      attribute :assistance_year, Types::Integer.meta(omittable: false)
      # Date that is used on which to determine APTC Eligibility
      attribute :aptc_effective_date, Types::Date.optional.meta(omittable: false)

      # Add validation,
      # i) the assistance_year should be same as of effective_date.year(or)
      # ii) the assistance_year should be same as of (effective_date.year + 1)

      attribute :years_to_renew, Types::Integer.optional.meta(omittable: true)
      attribute :renewal_consent_through_year, Types::Integer.optional.meta(omittable: true)
      attribute :is_ridp_verified, Types::Bool.optional.meta(omittable: true)
      attribute :is_renewal_authorized, Types::Bool.optional.meta(omittable: true)
      attribute :applicants, Types::Array.of(Applicant).meta(omittable: false)
      attribute :tax_households, Types::Array.of(TaxHousehold).optional.meta(omittable: true)
      attribute :relationships, Types::Array.of(Relationship).optional.meta(omittable: true)

      attribute :us_state, Types::UsStateAbbreviationKind.meta(omittable: false)
      attribute :hbx_id, Types::String.meta(omittable: false)

      attribute :oe_start_on, Types::Date.optional.meta(omittable: false)

      attribute :notice_options, NoticeOptions.optional.meta(omittable: false)

      # Set of attributes specific to MitC which helps to not have much logic in IapTo MitC Transform.
      attribute :mitc_households, Types::Array.of(AcaEntities::MagiMedicaid::Mitc::Household).optional.meta(omittable: true)
      attribute :mitc_tax_returns, Types::Array.of(AcaEntities::MagiMedicaid::Mitc::TaxReturn).optional.meta(omittable: true)

      # Should have Product, PremiumTable and PremiumTuple
      # attribute :benchmark_product, ::AcaEntities::BenefitMarkets::Product.meta(omittable: false)

      # Method to return relationship from applicant to relative
      # Example: if A is parent to B, relationship_kind(A, B) returns 'parent'
      def relationship_kind(applicant, relative)
        return 'self' if applicant.person_hbx_id == relative.person_hbx_id
        return nil if relationships.blank?

        relation = relationships.detect do |rel|
          rel.applicant_reference.person_hbx_id == applicant.person_hbx_id &&
            rel.relative_reference.person_hbx_id == relative.person_hbx_id
        end

        relation&.kind
      end

      def applicant_relationships(applicant)
        return [] if relationships.blank?

        relationships.select do |rel|
          rel.applicant_reference.person_hbx_id == applicant.person_hbx_id
        end
      end

      def spouse_relationships(applicant)
        return [] if relationships.blank?

        relationships.select do |rel|
          rel.applicant_reference.person_hbx_id == applicant.person_hbx_id && rel.kind == 'spouse'
        end
      end

      def primary_applicant
        applicants.detect(&:is_primary_applicant)
      end
    end
  end
end
