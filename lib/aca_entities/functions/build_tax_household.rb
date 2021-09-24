# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module AcaEntities
  module Functions
    # taxhousehold builder
    class BuildTaxHouseHold
      def call(context)
        return [] unless context.find('is_applying_for_assistance')&.first&.item == true
        begin
          @primary_applicant_id = context.resolve('family.family_members.is_primary_applicant').item
          tax_households = context.find(Regexp.new("computed.taxHouseholds"))

          # multi tax household scenario is not devveloped for maine
          # currently combining both multi taxhouseholds to one tax household
          # TODO: refactor below for multiple tax households creation
          # household_member_identifiers = tax_households.collect {|obj|  obj.name.split('.').last }.flatten.compact

          tax_households.collect do |obj|
            household_member_identifier = obj.name.split('.').last
            tax_composition_member_identifiers = obj.item.dig(:taxHouseHoldComposition, :taxHouseholdMemberIdentifiers, 0,
                                                              :taxHouseholdMemberIdentifiers)
            tax_household_members =
              if tax_composition_member_identifiers.nil?
                [{
                  family_member_reference: { family_member_hbx_id: household_member_identifier,
                                             first_name: '',
                                             last_name: '',
                                             person_hbx_id: '',
                                             is_primary_family_member: (@primary_applicant_id == household_member_identifier) },
                  product_eligibility_determination: { is_ia_eligible: false },
                  is_subscriber: (@primary_applicant_id == household_member_identifier),
                  reason: ""
                }]
              else
                tax_composition_member_identifiers.collect do |tax_composition_member_identifier|
                  {
                    family_member_reference: { family_member_hbx_id: tax_composition_member_identifier,
                                               first_name: '',
                                               last_name: '',
                                               person_hbx_id: '',
                                               is_primary_family_member: (@primary_applicant_id == tax_composition_member_identifier) },
                    product_eligibility_determination: { is_ia_eligible: true },
                    is_subscriber: (@primary_applicant_id == tax_composition_member_identifier),
                    reason: ""
                  }
                end
              end

            max_aptc = obj.item.dig(:maxAPTC, :maxAPTCAmount).to_f
            tax_household_annual_income = obj.item.dig(:maxAPTC, :taxHouseholdAnnualIncomeAmount).to_f

            {
              hbx_id: "1234",
              allocated_aptc: { cents: 0, currency_iso: "USD" },
              is_eligibility_determined: true,
              start_date: Date.new(2021, 1, 1), # default value
              end_date: Date.new(2021, 12, 31), # default value
              tax_household_members: tax_household_members&.flatten&.compact,
              eligibility_determinations: [{
                max_aptc: { cents: max_aptc, currency_iso: "USD" },
                csr_percent_as_integer: 0, # default value
                determined_at: Date.new(2021, 1, 1), # default value
                aptc_csr_annual_household_income: { cents: tax_household_annual_income, currency_iso: "USD" },
                aptc_annual_income_limit: { cents: 0, currency_iso: "USD" },
                csr_annual_income_limit: { cents: 0, currency_iso: "USD" }
              }]
            }
          end
        rescue StandardError => e
          puts "errors BuildTaxHouseHold  #{e}"
        end
      end
    end
  end
end
# rubocop:enable Metrics/MethodLength