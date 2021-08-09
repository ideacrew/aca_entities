# frozen_string_literal: true
# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
module AcaEntities
  module Functions
    class BuildTaxHouseHold
      def call(context)
        return [] unless context.find('is_applying_for_assistance')&.first&.item == true
        begin

        @memoized_data = context
        @primary_applicant_id = @memoized_data.resolve('family.family_members.is_primary_applicant').item
        tax_info = @memoized_data.find(Regexp.new("computed.taxHouseholds"))&.first.item
        # binding.pry
        max_aptc = tax_info[:maxAPTC][:maxAPTCAmount] if tax_info[:maxAPTC]  #TODO: APTC not available for all
        return [] if tax_info[:taxHouseHoldComposition][:taxHouseholdMemberIdentifiers]&.first.nil?  #TODO
        tax_household_members = tax_info[:taxHouseHoldComposition][:taxHouseholdMemberIdentifiers]&.first[:taxHouseholdMemberIdentifiers]
        @members = []
        tax_household_members.each do |member_id|
          @members << {
              family_member_reference: { family_member_hbx_id: member_id,
                                         first_name: '',
                                         last_name: '',
                                         person_hbx_id: '',
                                         is_primary_family_member: (@primary_applicant_id == member_id) },
              product_eligibility_determination: { is_ia_eligible: true },
              is_subscriber: @primary_applicant_id == member_id,
              reason: ""
          }
        end
        [ hbx_id: 1234,
          allocated_aptc: {"cents"=> max_aptc, "currency_iso"=>"USD"},
          is_eligibility_determined: true,
          start_date: Date.new(2021,1,1),
          end_date: Date.new(2021,12,31),
          tax_household_members: @members,
          eligibility_determinations:[]
        ]
        rescue => e

          # binding.pry
          []
        end
      end
    end
  end
end
