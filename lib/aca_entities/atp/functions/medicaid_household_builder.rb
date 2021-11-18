# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class MedicaidHouseholdBuilder

        INCOME_FIELDS = [:category_code, :amount, :frequency].freeze

        def call(cache)
          @memoized_data = cache
          applicants_hash = @memoized_data.resolve('family.magi_medicaid_applications.applicants').item
          mitc_households = @memoized_data.resolve('family.magi_medicaid_applications.mitc_households').item

          mitc_households.values.each_with_object([]) do |household, collect|
            people = household[:people].map { |p| p[:person_id] }
            incomes = find_incomes(people, applicants_hash)&.flatten
            incomes.map! {|i| i.select {|k, _v| INCOME_FIELDS.include?(k)}}
            member_references = people.map {|p| { ref: "SBM#{p}" }}

            collect << {
              household_incomes: incomes,
              household_member_references: member_references,
              effective_person_quantity: people.count
              #   income_above_highest_applicable_magi_standard_indicator: nil # TODO: determine correct mapping
            }
          end
        end

        def find_primary_tax_filer(filers, applicants_hash)
          head_of_household = filers.map(&:to_sym) & applicants_hash.select {|_k, v| v[:is_filing_as_head_of_household] == true}.keys
          return head_of_household unless head_of_household.empty?

          filers.map(&:to_sym) & applicants_hash.select {|_k, v| v[:is_primary_applicant].present?}.keys
        end

        def find_spouse_tax_filer(filers, person_relationships)
          person_relationships.select {|h| h[:relationship_code] == "02"}.each do |rel|
            return rel[:other_id] unless ([rel[:other_id]] & filers).empty?
          end
        end

        def find_incomes(people, applicants_hash)
          people.map(&:to_sym).each_with_object([]) do |person, collect|
            collect << find_person_incomes(person, applicants_hash)
            collect
          end
        end

        def find_person_incomes(person, applicants_hash)
          incomes = applicants_hash.dig(person, :incomes)
          incomes.each_with_object([]) do |income, collect|
            atp_income = ::AcaEntities::Atp::Transformers::Aces::Income.transform(income)
            collect << atp_income
          end
        end
      end
    end
  end
end