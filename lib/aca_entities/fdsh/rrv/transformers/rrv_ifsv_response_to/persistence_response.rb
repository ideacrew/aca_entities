# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Rrv
      module Transformers
        module RrvIfsvResponseTo
          class PersistenceResponse < ::AcaEntities::Operations::Transforms::Transform
            include ::AcaEntities::Operations::Transforms::Transformer

            namespace 'IfsvApplicantResponseGroup' do
              rewrap 'household', type: :hash do
                rewrap 'income' do
                  map "AggregateHouseholdIncomeAmt", "income_amount"
                end

                namespace 'IFSVApplicantVerifications' do
                  rewrap 'applicant_verifications', type: :array do
                    rewrap '' do
                      rewrap 'tax_return', type: :hash do
                        map 'TaxpayerIdentificationNumber', 'tax_identification_number'
                        map 'SpouseTIN', 'spouse_tin' 
                        map 'TaxYear', 'tax_year'
                        map 'IndividualReturnFilingStatusCd', 'IndividualReturnFilingStatusCd'
                        map 'ComputerTaxableSocSecAmt', 'ComputerTaxableSocSecAmt'
                        map 'AdjustedGrossIncomeAmt', 'AdjustedGrossIncomeAmt'
                        map 'IncomeAmt', 'IncomeAmt'
                        map 'TotalExemptionsCnt', 'TotalExemptionsCnt'
                      end

                      namespace 'IFSVResponseCodeDetails' do
                        rewrap 'response_metadata', type: :array do
                          rewrap '' do
                            map 'ResponseCd', 'response_code'
                            map 'ResponseCodeDescription', 'response_description_text'
                          end
                        end
                      end
                    end
                  end
                end

                namespace 'IFSVDependentVerifications' do
                  rewrap 'dependent_verifications', type: :array do
                    rewrap '' do
                      namespace 'IFSVApplicantVerification' do
                        rewrap 'tax_return', type: :hash do
                          map 'TaxpayerIdentificationNumber',  'tax_identification_number'
                          map 'SpouseTIN', 'spouse_TIN' 
                          map 'TaxYear', 'tax_year'
                          map 'IndividualReturnFilingStatusCd', 'IndividualReturnFilingStatusCd'
                          map 'ComputerTaxableSocSecAmt', 'ComputerTaxableSocSecAmt'
                          map 'AdjustedGrossIncomeAmt', 'AdjustedGrossIncomeAmt'
                          map 'IncomeAmt', 'IncomeAmt'
                          map 'TotalExemptionsCnt', 'TotalExemptionsCnt'
                        end

                        namespace 'IFSVResponseCodeDetails' do
                          rewrap 'response_metadata', type: :array do
                            rewrap '' do
                              map 'ResponseCd', 'response_code'
                              map 'ResponseCodeDescription', 'response_description_text'
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
