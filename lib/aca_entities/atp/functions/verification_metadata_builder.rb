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
            latest_vlp_response = consumer_role[:lawful_presence_determination][:vlp_responses]&.max_by { |document| document[:received_at] }

            collector << construct_ssa_verification_response(latest_ssa_response, hbx_id) if latest_ssa_response.present?
            collector << construct_vlp_verification(latest_vlp_response, hbx_id) if latest_vlp_response.present?
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

        def construct_vlp_verification(latest_vlp_response, hbx_id)
          parsed_response = JSON.parse(latest_vlp_response[:body])
          response_code = extract_response_code(parsed_response)
          verification_description_text = extract_verification_description_text(parsed_response)
          dhs_save_verification_code = extract_dhs_save_verification_code(parsed_response)
          dhs_save_verification = construct_dhs_save_verification_supplement(parsed_response)
          verification_date = DateTime.parse(latest_vlp_response[:received_at])
          verification_category_codes = determine_verification_category_codes(dhs_save_verification)

          {
            id: "vmdhs#{hbx_id}",
            dhs_save_verification_code: dhs_save_verification_code,
            verification_date: { date_time: verification_date },
            verification_requesting_system: { category_code: "Exchange" },
            verification_status: { status_code: "5" },
            verification_authority_alpha_code: "DHS",
            dhs_save_verification_supplement: dhs_save_verification,
            response_code: response_code,
            verification_description_text: verification_description_text,
            verification_category_codes: verification_category_codes
          }.compact
        end

        def extract_response_code(parsed_response)
          parsed_response.dig("ResponseMetadata", "ResponseCode")
        end

        def extract_verification_description_text(parsed_response)
          parsed_response.dig("ResponseMetadata", "ResponseDescriptionText")
        end

        def extract_dhs_save_verification_code(parsed_response)
          parsed_response.dig(
            "InitialVerificationResponseSet",
            "InitialVerificationIndividualResponses",
            0,
            "InitialVerificationIndividualResponseSet",
            "EligStatementCd"
          ).to_s
        end

        def construct_dhs_save_verification_supplement(parsed_response)
          response_set = extract_initial_verification_response_set(parsed_response)
          lawful_presence_code = extract_lawful_presence_code(parsed_response)

          {
            step_id: "1",
            case_number: response_set["CaseNumber"],
            eligibility_statement_code: response_set["EligStatementCd"],
            lawful_presence_verification_code: lawful_presence_code,
            five_year_bar_verification_code: fetch_ffe_verification_code(response_set["FiveYearBarApplyCode"]),
            qualified_non_citizen_verification_code: fetch_ffe_verification_code(response_set["QualifiedNonCitizenCode"]),
            five_year_bar_met_verification_code: fetch_ffe_verification_code(response_set["FiveYearBarMetCode"]),
            us_citizenship_verification_code: fetch_ffe_verification_code(response_set["USCitizenCode"])
          }.compact
        end

        def extract_initial_verification_response_set(parsed_response)
          parsed_response.dig(
            "InitialVerificationResponseSet",
            "InitialVerificationIndividualResponses",
            0,
            "InitialVerificationIndividualResponseSet"
          )
        end

        def extract_lawful_presence_code(parsed_response)
          parsed_response.dig(
            "InitialVerificationResponseSet",
            "InitialVerificationIndividualResponses",
            0,
            "LawfulPresenceVerifiedCode"
          )
        end

        def fetch_ffe_verification_code(code)
          return unless %w[Y N P I].include?(code)

          code
        end

        def determine_verification_category_codes(dhs_save_verification)
          ["EligibleImmigrationStatus"] if dhs_save_verification[:lawful_presence_verification_code] == "Y"
        end
      end
    end
  end
end
