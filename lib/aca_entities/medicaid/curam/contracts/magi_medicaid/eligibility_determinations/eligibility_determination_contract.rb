# frozen_string_literal: true

module Ehs
  class MagiMedicaid::EligibilityDeterminations::EligibilityDeterminationContract < Ehs::ApplicationContract
    params do
      required(:source_system_identifier).filled(:hash)
      required(:determined_at).filled(:date_time)
      required(:tax_households).array(:hash)
    end

    rule(:source_system_identifier) do
      if key? && value
        if value.is_a?(Hash)
          result = Identifiers::IdContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid source_system_identifier', error: result.errors.to_h)
          else
            values.merge!(source_system_identifier: result.to_h)
          end
        else
          key.failure(text: 'invalid source_system_identifier. Expected a hash.')
        end
      end
    end

    rule(:tax_households) do
      if key? && value
        thhs_array = value.inject([]) do |hash_array, thh_hash|
                       if thh_hash.is_a?(Hash)
                         result = TaxHouseholds::TaxHouseholdContract.new.call(thh_hash)
                           if result&.failure?
                             key.failure(text: 'invalid tax household', error: result.errors.to_h)
                           else
                             hash_array << result.to_h
                           end
                       else
                         key.failure(text: 'invalid tax household. Expected a hash.')
                       end
                       hash_array
                     end
        values.merge!(tax_households: thhs_array)
      end
    end
  end
end
