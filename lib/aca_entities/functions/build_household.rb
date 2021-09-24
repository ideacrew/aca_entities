# frozen_string_literal: true

module AcaEntities
  module Functions
    # Build coverage household and coverage household members
    class BuildHousehold
      # IMMEDIATE_FAMILY = %w[self spouse life_partner child ward foster_child adopted_child
      # stepson_or_stepdaughter stepchild domestic_partner].freeze

      def call(input)
        members = input.find(/attestations.members.(\w+)$/).map(&:item)
        primary_applicant_id = input.resolve('family.family_members.is_primary_applicant').item

        [start_date: Date.parse('2021-01-01'),
         irs_group_reference: {},
         is_active: true,
         irs_group: nil,
         hbx_enrollments: [],
         hbx_id: '1234',
         foreign_keys: [],
         tax_households: AcaEntities::Functions::BuildTaxHouseHold.new.call(input),
         coverage_households: [
           { is_immediate_family: true,
             coverage_household_members: members.each_with_object([]) do |member_id, result|
                                           person_number = input.find(Regexp.new("computed.members.#{member_id}")).first.item[:personTrackingNumber]
                                           result << { is_subscriber: (primary_applicant_id == member_id),
                                                       family_member_reference: { family_member_hbx_id: member_id,
                                                                                  first_name: '',
                                                                                  last_name: '',
                                                                                  person_hbx_id: person_number,
                                                                                  is_primary_family_member: (primary_applicant_id == member_id) } }
                                           result
                                         end }
         ]]
      end
    end
  end
end
