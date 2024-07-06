# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class VerificationMetadataBuilder

        def call(cache)
          @memoized_data = cache
          @all_consumer_roles = @memoized_data.find(/family.family_members.(\w+).person.consumer_role$/)
          @all_consumer_roles.each_with_object([]) do |consumer_role_object, collector|
            name = consumer_role_object.name
            hbx_id = name.match(/\d+/)[0]
            consumer_role = consumer_role_object.item
            latest_ssa_response = consumer_role[:lawful_presence_determination][:ssa_responses]&.max_by { |document| document[:received_at] }
            next if latest_ssa_response.nil?

            collector << construct_ssa_verification_response(latest_ssa_response, hbx_id) if latest_ssa_response.present?
          end.compact
        end

        def construct_ssa_verification_response(latest_ssa_response, hbx_id)
          parsed_response = JSON.parse(latest_ssa_response[:body])
          response_metadata = parsed_response["ResponseMetadata"]
          ssa_response = parsed_response["SSACompositeIndividualResponses"][0]["SSAResponse"]

          {
            id: "vmssa#{hbx_id}",
            ffe_verification_code: "Y",
            verification_date: { date_time: DateTime.parse(latest_ssa_response[:received_at]) },
            verification_requesting_system: { category_code: "Exchange" },
            verification_indicator: ssa_response["SSNVerificationIndicator"],
            verification_status: { status_code: "5" },
            verification_authority_alpha_code: "SSA",
            verification_description_text: response_metadata["ResponseDescriptionText"],
            verification_category_codes: fetch_verification_category_codes(parsed_response),
            response_code: response_metadata["ResponseCode"]
          }
        end

        def fetch_verification_category_codes(parsed_response)
          category_codes = []

          # Define a mapping of keys to their corresponding category codes
          response_mapping = {
            "SSNVerificationIndicator" => 'SSN',
            "PersonUSCitizenIndicator" => 'Citizenship',
            "PersonIncarcerationInformationIndicator" => 'IncarcerationStatus'
          }

          # Iterate through the mapping and populate category_codes if present
          response_mapping.each do |key, code|
            indicator = parsed_response.dig("SSACompositeIndividualResponses", 0, "SSAResponse", key)
            category_codes << code unless indicator.nil?
          end

          category_codes
        end
      end
    end
  end
end
