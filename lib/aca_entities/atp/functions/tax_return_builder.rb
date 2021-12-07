# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/income'

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class TaxReturnBuilder
        # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
        def call(cache)
          @memoized_data = cache
          @applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          @member_id = @memoized_data.find(Regexp.new('is_primary_applicant.*')).select {|a|  a.item == true}.first.name.split('.').last
          @person_relationships = @applicants_hash[@member_id.to_sym][:mitc_relationships]
          tax_households = @memoized_data.resolve('family.magi_medicaid_applications.tax_households').item

          return unless tax_households
          tax_households.values.each_with_object([]) do |household, collect|
            members = household[:tax_household_members].map {|m| m.dig(:applicant_reference, :person_hbx_id)}

            primary_tax_filer = find_primary_tax_filer(members).first.to_s
            primary_role_reference = { ref: "pe#{primary_tax_filer}" }
            primary_hash = { role_reference: primary_role_reference } if primary_tax_filer.present?

            spouse_tax_filer = find_spouse_tax_filer(members)
            spouse_role_reference = { ref: "pe#{spouse_tax_filer}" }
            spouse_hash = { role_reference: spouse_role_reference } if spouse_tax_filer.present?

            dependents = find_dependents(members).map(&:to_s)
            dependents_hash = dependents.map do |id|
              claimed_by_custodial_parent = claimed_by_custodial_parent?(id)
              { role_reference: { ref: "pe#{id}" },
                claimed_by_custodial_parent_indicator: claimed_by_custodial_parent }
            end

            household_size_quantity = members.count
            household_member_references = members.map { |f| { ref: "pe#{f}" } }

            income = household.dig(:annual_tax_household_income, :cents)
            income_dollars = cents_to_dollars(income)&.to_f # convert to dollars
            incomes = [{ amount: income_dollars }] if income_dollars

            atp_tax_household = {
              household_incomes: incomes,
              household_size_quantity: household_size_quantity,
              primary_tax_filer: primary_hash,
              spouse_tax_filer: spouse_hash,
              tax_dependents: dependents_hash,
              household_member_references: household_member_references
            }
            atp_tax_return = {
              tax_household: atp_tax_household,
              tax_return_includes_dependent_indicator: dependents.any?
            }

            collect << atp_tax_return
          end
          # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity
        end

        def cents_to_dollars(income)
          return unless income && income.to_s.length > 2
          income.to_s.insert(-3, ".")
        end

        def find_primary_tax_filer(members)
          head_of_household = members.map(&:to_sym) & @applicants_hash.select {|_k, v| v[:is_filing_as_head_of_household] == true}.keys
          return head_of_household unless head_of_household.empty?

          members.map(&:to_sym) & @applicants_hash.select {|_k, v| v[:is_primary_applicant].present?}.keys
        end

        def find_spouse_tax_filer(members)
          @person_relationships.select {|h| h[:relationship_code] == "02"}.each do |rel|
            spouse = [rel[:other_id]] & members
            return spouse.first unless spouse.empty?
          end
        end

        def find_dependents(members)
          members.map(&:to_sym) & @applicants_hash.select {|_k, v| v[:is_claimed_as_tax_dependent] == true}.keys
        end

        def claimed_by_custodial_parent?(id)
          claimed_by = @applicants_hash[id.to_sym].dig(:claimed_as_tax_dependent_by, :person_hbx_id)
          @person_relationships.select {|h| h[:relationship_code] == "03"}.each do |rel|
            return true if rel[:other_id] == id && @member_id == claimed_by
          end
          false
        end
      end
    end
  end
end
