# frozen_string_literal: true

module AcaEntities
  module Functions
    # build person email
    class TaxFilerBuilder

      attr_reader :memoized_data, :member_identifier, :primary_applicant_identifier, :attestations_family_hash

      def call(memoized_data, member)
        @memoized_data = memoized_data
        @member_identifier = member.name.split('.').last
        @primary_applicant_identifier = memoized_data.resolve('family.family_members.is_primary_applicant').item
        @household_size = memoized_data.find(/attestations.members.(\w+)$/).map(&:item).count
        @attestations_family_hash = memoized_data.find(Regexp.new("attestations.members.#{member.name.split('.').last}.family"))&.first&.item

        member_tax_filing
      end

      private

      def member_tax_filing
        return { is_required_to_file_taxes: false } if attestations_family_hash.nil?
        household = memoized_data.resolve('attestations.household').item
        has_spouse_rel = household.present? && household[:familyRelationships].map do |rel|
          rel[:no_key][1][:no_key]
        end.flatten.include?('SPOUSE')

        has_multi_household = (attestations_family_hash[:taxFilerIndicator] && @household_size > 1 && has_spouse_rel)

        {
          is_required_to_file_taxes: attestations_family_hash[:taxFilerIndicator] || false,
          tax_filer_kind: tax_filer_kind,
          is_joint_tax_filing: has_multi_household ? attestations_family_hash[:taxReturnFilingStatusType] == 'MARRIED_FILING_JOINTLY' : nil,
          is_filing_as_head_of_household: has_multi_household ? attestations_family_hash[:taxReturnFilingStatusType] == 'HEAD_OF_HOUSEHOLD' : nil,
          is_claimed_as_tax_dependent: attestations_family_hash[:taxDependentIndicator] || false,
          claimed_as_tax_dependent_by: claimed_as_tax_dependent_hash
        }
      end

      def tax_filer_kind
        if attestations_family_hash[:taxFilerIndicator]
          "tax_filer"
        elsif attestations_family_hash[:taxDependentIndicator]
          "dependent"
        else
          "non_filer"
        end
      end

      def claimed_as_tax_dependent_hash
        person_hbx_id = claimed_as_tax_dependent_by.present? ? claimed_as_tax_dependent_by : "1234"
        { first_name: "dummy", last_name: 'dummy', dob: Date.parse("2021-01-01"), person_hbx_id: person_hbx_id }
      end

      def claimed_as_tax_dependent_by
        return unless attestations_family_hash[:taxDependentIndicator]

        household = memoized_data.resolve('attestations.household').item
        found_relationship = household[:taxRelationships].collect do |tax_relationship|
          primary_match = tax_relationship[:no_key][0][:no_key].include?(primary_applicant_identifier)
          current_member_match = tax_relationship[:no_key][0][:no_key].include?(member_identifier)
          tax_relationship[:no_key][0][:no_key] if (primary_match && current_member_match) || current_member_match
        end.compact

        return nil if found_relationship.blank?
        return found_relationship[0][0] if found_relationship.count == 1

        found_relationship_with_primary = found_relationship.detect do |relationship|
          relationship.include?(primary_applicant_identifier)
        end

        return found_relationship_with_primary[0] if found_relationship_with_primary.present?

        found_relationship_by_member = found_relationship.detect do |relationship|
          relationship.include?(member_identifier)
        end
        found_relationship_by_member[0]
      end
    end
  end
end

