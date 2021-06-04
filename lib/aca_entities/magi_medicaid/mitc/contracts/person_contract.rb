# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    module Mitc
      module Contracts
        # Schema and validation rules for {AcaEntities::MagiMedicaid::Mitc::Person}
        class PersonContract < Dry::Validation::Contract
          # @!method call(opts)
          # @param [Hash] opts the parameters to validate using this contract
          # @option opts [Integer] :person_id required
          # @option opts [String] :is_applicant required
          # @option opts [String] :is_blind_or_disabled required
          # @option opts [String] :is_full_time_student required
          # @option opts [String] :is_medicare_entitled required
          # @option opts [String] :is_incarcerated required
          # @option opts [String] :resides_in_state_of_application required
          # @option opts [String] :is_claimed_as_dependent_by_non_applicant required
          # @option opts [String] :is_self_attested_long_term_care required
          # @option opts [String] :has_insurance required
          # @option opts [String] :has_state_health_benefit required
          # @option opts [String] :had_prior_insurance required
          # @option opts [Date] :prior_insurance_end_date optional
          # @option opts [String] :is_pregnant required
          # @option opts [Integer] :children_expected_count optional
          # @option opts [String] :is_in_postpartum_period optional
          # @option opts [String] :is_in_former_foster_care required
          # @option opts [String] :had_medicaid_during_foster_care optional
          # @option opts [Integer] :age_left_foster_care optional
          # @option opts [String] :foster_care_us_state optional
          # @option opts [String] :is_required_to_file_taxes required
          # @option opts [String] :age_of_applicant required
          # @option opts [Integer] :hours_worked_per_week required
          # @option opts [String] :is_temporarily_out_of_state required
          # @option opts [String] :is_us_citizen required
          # @option opts [String] :is_lawful_presence_self_attested required
          # @option opts [String] :immigration_status optional
          # @option opts [String] :is_amerasian optional
          # @option opts [String] :has_forty_title_ii_work_quarters optional
          # @option opts [String] :five_year_bar_applies optional
          # @option opts [String] :is_five_year_bar_met optional
          # @option opts [String] :is_trafficking_victim required
          # @option opts [String] :is_eligible_for_refugee_medical_assistance required
          # @option opts [Date] :refugee_medical_assistance_start_date optional
          # @option opts [Date] :seven_year_limit_start_date optional
          # @option opts [String] :is_veteran required
          # @option opts [Hash] :income required
          # @option opts [Array] :relationships required
          # @return [Dry::Monads::Result]
          params do
            required(:person_id).filled(:integer)
            required(:is_applicant).filled(Types::YesNoKind)
            required(:is_blind_or_disabled).filled(Types::YesNoKind)
            required(:is_full_time_student).filled(Types::YesNoKind)
            required(:is_medicare_entitled).filled(Types::YesNoKind)
            required(:is_incarcerated).filled(Types::YesNoKind)
            required(:resides_in_state_of_application).filled(Types::YesNoKind)
            required(:is_claimed_as_dependent_by_non_applicant).filled(Types::YesNoKind)
            required(:is_self_attested_long_term_care).filled(Types::YesNoKind)
            required(:has_insurance).filled(Types::YesNoKind)
            required(:has_state_health_benefit).filled(Types::YesNoKind)
            required(:had_prior_insurance).filled(Types::YesNoKind)
            optional(:prior_insurance_end_date).maybe(:date)
            required(:is_pregnant).filled(Types::YesNoKind)
            optional(:children_expected_count).maybe(:integer)
            optional(:is_in_postpartum_period).maybe(Types::YesNoKind)
            required(:is_in_former_foster_care).filled(Types::YesNoKind)
            optional(:had_medicaid_during_foster_care).maybe(Types::YesNoKind)
            optional(:age_left_foster_care).maybe(:integer)
            optional(:foster_care_us_state).maybe(Types::UsStateAbbreviationKind)
            required(:is_required_to_file_taxes).filled(Types::YesNoKind)
            required(:age_of_applicant).filled(:integer)
            required(:hours_worked_per_week).filled(:integer)
            required(:is_temporarily_out_of_state).filled(Types::YesNoKind)
            required(:is_us_citizen).filled(Types::YesNoKind)
            required(:is_lawful_presence_self_attested).filled(Types::YesNoKind)
            optional(:immigration_status).maybe(Types::ImmigrationStatusKind)
            optional(:is_amerasian).maybe(Types::YesNoKind)
            optional(:has_forty_title_ii_work_quarters).maybe(Types::YesNoKind)
            optional(:five_year_bar_applies).maybe(Types::YesNoKind)
            optional(:is_five_year_bar_met).maybe(Types::YesNoKind)
            required(:is_trafficking_victim).filled(Types::YesNoKind)
            required(:is_eligible_for_refugee_medical_assistance).filled(Types::YesNoKind)
            optional(:refugee_medical_assistance_start_date).maybe(Types::Date)
            optional(:seven_year_limit_start_date).maybe(Types::Date)
            required(:is_veteran).filled(Types::YesNoKind)
            required(:income).hash(IncomeContract.params)
            required(:relationships).array(RelationshipContract.params)
          end
        end
      end
    end
  end
end
