# frozen_string_literal: true

module AcaEntities
  module Atp
    module Functions
      # Transformers implementation for atp payloads
      class VerificationMetadataBuilder

        Mapper = {
          "is_incarcerated" => "Incarceration"
        }.freeze

        def call(cache)
          primary_applicant_id = cache.find(Regexp.new("is_primary_applicant.*")).select {|i| i.item == true}.last.name.split('.').last
          incarceration_indicator = cache.find(Regexp.new("is_incarcerated.#{primary_applicant_id}")).last
          verification_description_text = incarceration_indicator.name.split(".").first if incarceration_indicator

          if incarceration_indicator.nil? || incarceration_indicator.empty?
            []
          elsif !incarceration_indicator.empty?
            [{ id: "vm2009583325215611507", # default value
               verification_date: { date_time: DateTime.now }, # default value
               verification_requesting_system: { id: "IDC2009583325215611507", category_code: "Exchange" }, # default value
               verification_indicator: true, # default value
               verification_description_text: Mapper[verification_description_text],
               verification_status: { status_code: "5" }, # default value
               verification_authority_alpha_code: "SSA" }] # default value
          end
        end
      end
    end
  end
end
