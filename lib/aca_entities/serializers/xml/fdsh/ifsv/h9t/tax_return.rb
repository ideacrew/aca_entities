# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class TaxReturn
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'
              register_namespace 'hee', 'http://hix.cms.gov/0.1/hix-ee'

              tag 'TaxReturn'
              namespace 'ext'

              has_one :PrimaryTaxFiler, PrimaryTaxFiler
              has_one :SpouseTaxFiler, SpouseTaxFiler
              element :TaxReturnYear, String, tag: 'TaxReturnYear', namespace: "hee"
              element :TaxReturnFilingStatusCode, String, tag: 'TaxReturnFilingStatusCode', namespace: "hee"
              element :TaxReturnAGIAmount, Float, tag: 'TaxReturnAGIAmount', namespace: "hee"
              element :TaxReturnMAGIAmount, Float, tag: 'TaxReturnMAGIAmount', namespace: "hee"
              element :TaxReturnTaxableSocialSecurityBenefitsAmount, Float, tag: 'TaxReturnTaxableSocialSecurityBenefitsAmount', namespace: "hee"
              element :TaxReturnTotalExemptionsQuantity, Integer, tag: 'TaxReturnTotalExemptionsQuantity', namespace: "hee"

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.PrimaryTaxFiler = PrimaryTaxFiler.domain_to_mapper(response.PrimaryTaxFiler)
                mapper.SpouseTaxFiler = SpouseTaxFiler.domain_to_mapper(response.SpouseTaxFiler)
                mapper.TaxReturnYear = response.TaxReturnYear
                mapper.TaxReturnFilingStatusCode = response.TaxReturnFilingStatusCode
                mapper.TaxReturnAGIAmount = response.TaxReturnAGIAmount
                mapper.TaxReturnMAGIAmount = response.TaxReturnMAGIAmount
                mapper.TaxReturnTaxableSocialSecurityBenefitsAmount = response.TaxReturnTaxableSocialSecurityBenefitsAmount
                mapper.TaxReturnTotalExemptionsQuantity = response.TaxReturnTotalExemptionsQuantity

                mapper
              end
            end
          end
        end
      end
    end
  end
end