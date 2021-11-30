# frozen_string_literal: true

require 'aca_entities/atp/transformers/aces/income'

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class NonEsiBuilder
        # rubocop:disable Metrics/MethodLength
        def call(cache)
          #p cache
          # rubocop:enable Metrics/MethodLength
        end

        def cents_to_dollars(income)
          return unless income && income.to_s.length > 2
          income.to_s.insert(-3, ".")
        end

        def find_primary_tax_filer(members, applicants_hash)
          head_of_household = members.map(&:to_sym) & applicants_hash.select {|_k, v| v[:is_filing_as_head_of_household] == true}.keys
          return head_of_household unless head_of_household.empty?

          members.map(&:to_sym) & applicants_hash.select {|_k, v| v[:is_primary_applicant].present?}.keys
        end

        def find_spouse_tax_filer(members, person_relationships, _member_id)
          person_relationships.select {|h| h[:relationship_code] == "02"}.each do |rel|
            spouse = [rel[:other_id]] & members
            return spouse.first unless spouse.empty?
          end
        end

        def find_dependents(members, applicants_hash)
          members.map(&:to_sym) & applicants_hash.select {|_k, v| v[:is_claimed_as_tax_dependent] == true}.keys
        end
      end
    end
  end
end
