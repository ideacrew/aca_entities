# frozen_string_literal: true

module Ehs
  class MagiMedicaid::Applications::ApplicationContract < Ehs::ApplicationContract
    params do
      required(:source_system_identifier).filled(:hash)
      required(:submitted_at).filled(:date_time)
      required(:eligibility_determinations).array(:hash)
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

    rule(:eligibility_determinations) do
      if key? && value
        eds_array = value.inject([]) do |hash_array, ed_hash|
                      if ed_hash.is_a?(Hash)
                        result = MagiMedicaid::EligibilityDeterminations::EligibilityDeterminationContract.new.call(ed_hash)
                        if result&.failure?
                          key.failure(text: 'invalid eligibility determination', error: result.errors.to_h)
                        else
                          hash_array << result.to_h
                        end
                      else
                        key.failure(text: 'invalid eligibility determination. Expected a hash.')
                      end
                      hash_array
                    end
        values.merge!(eligibility_determinations: eds_array)
      end
    end
  end
end
