# frozen_string_literal: true

module Ehs
  module IntegratedCases
    class IntegratedCaseContract < Ehs::ApplicationContract

      params do
        optional(:source_system_key).maybe(:string)
        required(:ids).array(:hash)
        optional(:primary_person).maybe(:hash)
        optional(:case_reference).maybe(:string)
        optional(:esnap_flag).maybe(:bool)
        required(:applications).array(:hash)
        optional(:evidences).array(:hash)
        optional(:product_delivery_cases).array(:hash)
        required(:last_updated_at).maybe(:date_time)
      end

      rule(:primary_person) do
        if key? && value
          if value.is_a?(Hash)
            result = People::PersonContract.new.call(value)
            if result&.failure?
              key.failure(text: 'invalid primary_person', error: result.errors.to_h)
            else
              values.merge!(primary_person: result.to_h)
            end
          else
            key.failure(text: 'invalid primary_person. Expected a hash.')
          end
        end
      end

      rule(:applications) do
        if key? && value
          applications_array =  value.inject([]) do |hash_array, appl_hash|
                                  if appl_hash.is_a?(Hash)
                                    result = Applications::ApplicationContract.new.call(appl_hash)
                                    if result&.failure?
                                      key.failure(text: 'invalid application', error: result.errors.to_h)
                                    else
                                      hash_array << result.to_h
                                    end
                                  else
                                    key.failure(text: 'invalid application. Expected a hash.')
                                  end
                                  hash_array
                                end
          values.merge!(applications: applications_array)
        end
      end

      rule(:evidences) do
        if key? && value
          evidences_array =  value.inject([]) do |hash_array, evidence_hash|
                                          if evidence_hash.is_a?(Hash)
                                            result = Evidences::EvidenceContract.new.call(evidence_hash)
                                            if result&.failure?
                                              key.failure(text: 'invalid evidences', error: result.errors.to_h)
                                            else
                                              hash_array << result.to_h
                                            end
                                          else
                                            key.failure(text: 'invalid evidences. Expected a hash.')
                                          end
                                          hash_array
                                        end
          values.merge!(evidences: evidences_array)
        end
      end
    end
  end
end
