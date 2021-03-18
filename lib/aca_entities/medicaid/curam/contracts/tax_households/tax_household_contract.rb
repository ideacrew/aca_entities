# frozen_string_literal: true

module Ehs
  class TaxHouseholds::TaxHouseholdContract < Ehs::ApplicationContract
    params do
      required(:maximum_aptc).filled(:decimal)
      required(:csr_percent).filled(:decimal)
      required(:tax_household_members).array(:hash)
    end

    rule(:tax_household_members) do
      if key? && value
        thhms_array = value.inject([]) do |hash_array, thhm_hash|
                        if thhm_hash.is_a?(Hash)
                          result = TaxHouseholds::TaxHouseholdMemberContract.new.call(thhm_hash)
                          if result&.failure?
                            key.failure(text: 'invalid tax household member', error: result.errors.to_h)
                          else
                            hash_array << result.to_h
                          end
                        else
                          key.failure(text: 'invalid tax household member. Expected a hash.')
                        end
                        hash_array
                      end
        values.merge!(tax_household_members: thhms_array)
      end
    end
  end
end
