# frozen_string_literal: true

module Ehs
  class TaxHouseholds::TaxHouseholdMemberContract < Ehs::ApplicationContract
    params do
      required(:person_identifiers).array(:hash)
      required(:is_ia_eligible).filled(:bool)
      required(:is_medicaid_chip_eligible).filled(:bool)
      optional(:is_without_assistance).maybe(:bool)
      required(:financial_statements).array(:hash)
    end

    rule(:person_identifiers) do
      if key? && value
        identifiers_array = value.inject([]) do |hash_array, id_hash|
                            if id_hash.is_a?(Hash)
                              result = Identifiers::IdContract.new.call(id_hash)
                              if result&.failure?
                                key.failure(text: 'invalid identifier', error: result.errors.to_h)
                              else
                                hash_array << result.to_h
                              end
                            else
                              key.failure(text: 'invalid identifier. Expected a hash.')
                            end
                            hash_array
                          end
        values.merge!(person_identifiers: identifiers_array)
      end
    end
  end
end
