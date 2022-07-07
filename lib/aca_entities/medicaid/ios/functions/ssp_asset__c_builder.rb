# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Ios
      module Functions
        # build SSP_Asset__c for IOS transform
        class SspAssetCBuilder
          def call(cache)
            @memoized_data = cache
            # TO DO
            # loop through incomes and deductions
            # build hash of field mappings
            # return array of transformed SSP_Asset__c hashes
            # [] # mocked return array for initial spec

            application = @memoized_data.resolve('family.magi_medicaid_applications').item
            applicants = application[:applicants]
            incomes = applicants.map {|applicant| applicant[:incomes]}.flatten
            deductions = applicants.map {|applicant| applicant[:deductions]}.flatten

            asset_incomes = incomes.map do |income|
              {}
            end

            asset_deductions = deductions.each do |deduction|
              {}
            end

            asset_incomes + asset_deductions
          end
        end
      end
    end
  end
end