# frozen_string_literal: true

require 'aca_entities/medicaid/ios/types'

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Asset__c for IOS transform
        class SspAssetCBuilder

          def call(cache)
            application = cache.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            incomes = applicants.map {|applicant| applicant[:incomes]}.flatten
            deductions = applicants.map {|applicant| applicant[:deductions]}.flatten

            asset_incomes = incomes.map do |income|
              {
                # 'Id' => generate_hash,
                'IncomeTypeCode__c' => AcaEntities::Medicaid::Ios::Types::INCOME_TYPE_MAP[income&.dig(:kind)&.upcase],
                # 'IncomeSubtypeCode__c' => income&.dig(:subtype)&.upcase,
                'StartDate__c' => income&.dig(:start_on),
                'TotalGrossAmount__c' => income&.dig(:amount),
                'IncomePayFrequency__c' => AcaEntities::Medicaid::Ios::Types::FREQUENCY_MAP[income&.dig(:frequency_kind)&.upcase],
                'EndDate__c' => income&.dig(:end_on),
                'EmployerName__c' => income&.dig(:employer, :employer_name),
                'PrimaryPhoneNumber__c' => income&.dig(:employer, :employer_phone, :full_phone_number)
              }
            end

            asset_deductions = deductions.map do |deduction|
              {
                # 'Id' => generate_hash,
                'StartDate__c' => deduction&.dig(:start_on),
                'ExpenseAmount__c' => deduction&.dig(:amount),
                'ExpenseFrequencyCode__c' => AcaEntities::Medicaid::Ios::Types::FREQUENCY_MAP[deduction&.dig(:frequency_kind)&.upcase],
                'ExpenseTypeCode__c' => AcaEntities::Medicaid::Ios::Types::EXPENSE_TYPE_MAP[deduction&.dig(:kind)&.downcase],
                'EndDate__c' => deduction&.dig(:end_on)
              }
            end
            asset_incomes + asset_deductions
          end
        end
      end
    end
  end
end