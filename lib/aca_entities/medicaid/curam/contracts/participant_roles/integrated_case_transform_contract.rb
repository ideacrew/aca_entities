# frozen_string_literal: true

module Ehs
  module ParticipantRoles
    class IntegratedCaseTransformContract < Ehs::ApplicationContract

      params do
        required(:source_system_key).filled(:string)
        required(:ids).array(:hash) do
          required(:key).filled(:string)
          required(:item).filled(:string)
          optional(:kind).maybe(:string)
          
          optional(:start_on).maybe(:date_time)
          optional(:end_on).maybe(:date_time)
        end
        required(:case_reference).filled(:string)
        optional(:esnap_flag).maybe(:bool)
        required(:product_delivery_cases).array(:hash)
        required(:participant_roles).array(:hash)
        optional(:last_updated_at).maybe(:date_time)
      end

      rule(:product_delivery_cases) do
        if key? && value
          applications_array =  value.inject([]) do |hash_array, appl_hash|
                                  if appl_hash.is_a?(Hash)
                                    result = ::Ehs::ParticipantRoles::ProductDeliveryCaseTransformContract.new.call(appl_hash)
                                    if result&.failure?
                                      key.failure(text: 'invalid product_delivery_case', error: result.errors.to_h)
                                    else
                                      hash_array << result.to_h
                                    end
                                  else
                                    key.failure(text: 'invalid product_delivery_case. Expected a hash.')
                                  end
                                  hash_array
                                end
          values.merge!(product_delivery_cases: applications_array)
        end
      end

      rule(:participant_roles) do
        if key? && value
          applications_array =  value.inject([]) do |hash_array, appl_hash|
                                  if appl_hash.is_a?(Hash)
                                    result = ::Ehs::ParticipantRoles::ParticipantRoleTransformContract.new.call(appl_hash)
                                    if result&.failure?
                                      key.failure(text: 'invalid participant_role', error: result.errors.to_h)
                                    else
                                      hash_array << result.to_h
                                    end
                                  else
                                    key.failure(text: 'invalid participant_role. Expected a hash.')
                                  end
                                  hash_array
                                end
          values.merge!(participant_roles: applications_array)
        end
      end
    end
  end
end