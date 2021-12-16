# frozen_string_literal: true

module AcaEntities
  module Eligibilities
    module Contracts
      # contract for EvidenceContract
      class SubjectContract < Dry::Validation::Contract
        params { required(:subjects).filled(:hash) }

        rule(:subjects) do
          values.to_h.slice(:subjects)[:subjects]
            .each_pair do |subject_key, determinations|
            result =
              AcaEntities::Eligibilities::Contracts::DeterminationContract.new
                .call(determinations)

            # require 'pry'
            # binding.pry
            next unless result.failure?
            result
              .errors
              .to_h
              .each do |path, message|
                # require 'pry'
                # binding.pry
                key([subject_key, determinations.keys.first, *path]).failure(
                  text: message
                )
              end
          end
        end
      end
    end
  end
end
