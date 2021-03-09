# frozen_string_literal: true

module AcaEntities
  module Contracts
    # Contract for EmployerSponsoredInsuranceInformation.
    class EmployerSponsoredInsuranceInformationContract < Dry::Validation::Contract

      params do
        optional(:employer_ein).maybe(:string)
        optional(:employer_name).maybe(:string)
        optional(:is_a_cobra_coverage).maybe(:bool)
        optional(:employee_status_code).maybe(Types::EmployeeStatusCodeKinds)
        optional(:changes_esi_status).maybe(:bool)
        optional(:retiree_plan_coverage).maybe(:bool)
        optional(:lcsop_coverage_code).maybe(Types::LcsopCoverageCodeKinds)
        optional(:lcsop_end_date).maybe(:date)
        optional(:lcsop_cost_code).maybe(Types::LcsopCostCodeKinds)
        optional(:lcsop_cost_change_date).maybe(:date)
        optional(:new_lcsop_premium).maybe(:float)
        optional(:is_employer_active).maybe(:bool)
        optional(:date_employer_drops_lcsop).maybe(:date)
        optional(:employee_do_not_know_lcsop_cost).maybe(:bool)
      end

      rule(:employer_ein) do
        if !value.to_s.empty? && !/[0-9]{9}/.match?(value)
          key.failure(text: 'Employer Identification Number should be numbers of size 9.')
        end
      end
    end
  end
end
