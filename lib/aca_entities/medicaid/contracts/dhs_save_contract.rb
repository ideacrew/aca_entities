# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Contracts
      # Contract for DhsSave.
      class DhsSaveContract < Dry::Validation::Contract

        params do
          optional(:class_of_admission_code).maybe(Types::ClassOfAdmissionCode)
          optional(:admission_end_date).maybe(:date)
          optional(:save_step).maybe(:string)
          optional(:case_nbr).maybe(:string)
          optional(:eligibility_statement_code).maybe(:string)
          optional(:lawful_presence_verified_code).maybe(:string)
          optional(:five_year_bar_code).maybe(:string)
          optional(:qualified_non_citizen_code).maybe(:string)
          optional(:five_year_bar_met_code).maybe(:string)
          optional(:us_citizen_code).maybe(:string)
          optional(:grant_date).maybe(:string)
          optional(:g_845_major_cd).maybe(:string)
          optional(:dhs_comments).maybe(:string)
        end
      end
    end
  end
end
