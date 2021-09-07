# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Transformers
          module IfsvVerificationResponseTo
            class PersistenceResponse < ::AcaEntities::Operations::Transforms::Transform
              include ::AcaEntities::Operations::Transforms::Transformer

              namespace 'ErrorMessage' do
                rewrap 'error_message', type: :hash do
                  namespace 'ErrorMessageDetail' do
                    rewrap 'error_message_detail', type: :hash do
                      namespace 'ResponseMetadata' do
                        rewrap 'response_metadata', type: :hash do
                          map 'ResponseCode', 'response_code'
                          map 'ResponseDescriptionText', 'response_description_text'
                          map 'TDSResponseDescriptionText', 'tds_response_description_text'
                        end
                      end
                      map 'XPathContent', 'xpath_detail'
                    end
                  end
                end
              end
              namespace 'IRSResponse' do
                rewrap 'irs_response', type: :hash do
                  map "RequestID", 'request_id'
                  namespace 'Household' do
                    rewrap 'household', type: :hash do
                      namespace 'Income' do
                        rewrap 'income' do
                          map "IncomeAmount", "income_amount"
                        end
                      end
                      namespace 'ApplicantVerifications' do
                        rewrap 'applicant_verifications', type: :array do
                          rewrap '' do
                            namespace 'TaxReturn' do
                              rewrap 'tax_return', type: :hash do
                                namespace 'PrimaryTaxFiler' do
                                  rewrap 'primary_tax_filer', type: :hash do
                                    map 'TINIdentification', 'tin_identification'
                                  end
                                end
                                namespace 'SpouseTaxFiler' do
                                  rewrap 'spouse_tax_filer', type: :hash do
                                    map 'TINIdentification', 'tin_identification'
                                  end
                                end
                                map 'TaxReturnYear', 'tax_return_year'
                                map 'TaxReturnFilingStatusCode', 'tax_return_filing_status_code'
                                map 'TaxReturnAGIAmount', 'tax_return_agi_amount'
                                map 'TaxReturnMAGIAmount', 'tax_return_magi_amount'
                                map 'TaxReturnTaxableSocialSecurityBenefitsAmount', 'tax_return_taxable_social_security_benefits_amount'
                                map 'TaxReturnTotalExemptionsQuantity', 'tax_return_total_exemptions_quantity'
                              end
                            end
                            namespace 'ResponseMetadata' do
                              rewrap 'response_metadata', type: :array do
                                rewrap '' do
                                  map 'ResponseCode', 'response_code'
                                  map 'ResponseDescriptionText', 'response_description_text'
                                  map 'TDSResponseDescriptionText', 'tds_response_description_text'
                                end
                              end
                            end
                          end
                        end
                      end
                      namespace 'DependentVerifications' do
                        rewrap 'dependent_verifications', type: :array do
                          rewrap '' do
                            namespace 'TaxReturn' do
                              rewrap 'tax_return', type: :hash do
                                namespace 'PrimaryTaxFiler' do
                                  rewrap 'primary_tax_filer', type: :hash do
                                    map 'TINIdentification', 'tin_identification'
                                  end
                                end
                                namespace 'SpouseTaxFiler' do
                                  rewrap 'spouse_tax_filer', type: :hash do
                                    map 'TINIdentification', 'tin_identification'
                                  end
                                end
                                map 'TaxReturnYear', 'tax_return_year'
                                map 'TaxReturnFilingStatusCode', 'tax_return_filing_status_code'
                                map 'TaxReturnAGIAmount', 'tax_return_agi_amount'
                                map 'TaxReturnMAGIAmount', 'tax_return_magi_amount'
                                map 'TaxReturnTaxableSocialSecurityBenefitsAmount', 'tax_return_taxable_social_security_benefits_amount'
                                map 'TaxReturnTotalExemptionsQuantity', 'tax_return_total_exemptions_quantity'
                              end
                            end
                            namespace 'ResponseMetadata' do
                              rewrap 'response_metadata', type: :array do
                                rewrap '' do
                                  map 'ResponseCode', 'response_code'
                                  map 'ResponseDescriptionText', 'response_description_text'
                                  map 'TDSResponseDescriptionText', 'tds_response_description_text'
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
  end
end
