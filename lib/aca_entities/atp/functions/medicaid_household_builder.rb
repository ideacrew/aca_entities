# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class MedicaidHouseholdBuilder

        INCOME_FIELDS = [:category_code, :amount, :frequency].freeze

        def call(cache)
          @memoized_data = cache
          family_id = @memoized_data.resolve("hbx_id").item
          tax_households = @memoized_data.resolve('family.magi_medicaid_applications.tax_households').item
          return unless tax_households

          tax_households.values.each_with_object([]) do |household, collect|
            income = household[:annual_tax_household_income]
            income_hash = {
              amount: income&.to_f,
              income_frequency: {
                frequency_code: "Annually" # default
              },
              category_code: "Unspecified" # default
            }
            members = household[:tax_household_members].map {|m| m.dig(:applicant_reference, :person_hbx_id)}
            member_references = members.map {|m| { ref: "pe#{m}" }}

            collect << {
              id: "mh#{family_id}#{household[:hbx_id]}",
              household_incomes: [income_hash],
              household_member_references: member_references,
              effective_person_quantity: members.count
              #   income_above_highest_applicable_magi_standard_indicator: nil # TODO: determine correct mapping
            }
          end
        end
      end
    end
  end
end