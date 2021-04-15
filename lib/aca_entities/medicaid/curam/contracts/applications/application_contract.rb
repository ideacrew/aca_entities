# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        # Contract for curam application
        class ApplicationContract < Curam::ApplicationContract

          params do
            optional(:source_system_key).maybe(:string)
            required(:ids).array(:hash)
            required(:status).filled(Curam::TypesApplicationStatusKind)
            required(:status_code).filled(Curam::TypesApplicationStatusCodeKind)
            required(:program_applications).array(:hash)
            optional(:people).array(:hash)
            optional(:product_delivery_cases).array(:hash)
            required(:last_updated_at).filled(:date_time)
            required(:filing_date).filled(:date)
            required(:submitted_at).filled(:date_time)
          end

          rule(:program_applications) do
            if key? && value
              program_applications_array = value.inject([]) do |hash_array, applications_hash|
                if applications_hash.is_a?(Hash)
                  result = Applications::ProgramApplicationContract.new.call(applications_hash)
                  if result&.failure?
                    key.failure(text: 'invalid program applications', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid program applications. Expected a hash.')
                end
                hash_array
              end
              values.merge!(program_applications: program_applications_array)
            end
          end

          rule(:people) do
            if key? && value
              people_array = value.inject([]) do |hash_array, people_hash|
                if people_hash.is_a?(Hash)
                  result = People::PersonContract.new.call(people_hash)
                  if result&.failure?
                    key.failure(text: 'invalid program applications', error: result.errors.to_h)
                  else
                    hash_array << result.to_h
                  end
                else
                  key.failure(text: 'invalid program applications. Expected a hash.')
                end
                hash_array
              end
              values.merge!(people: people_array)
            end
          end
        end
      end
    end
  end
end
