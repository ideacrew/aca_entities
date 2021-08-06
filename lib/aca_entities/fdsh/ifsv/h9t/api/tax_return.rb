# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        module Api
          # FTI Response Tax Return Namespace
          # @example XML Format
          #     <ext:TaxReturn>
          #         <hee:PrimaryTaxFiler>
          #             <hcore:TINIdentification>000000000</hcore:TINIdentification>
          #         </hee:PrimaryTaxFiler>
          #         <hee:SpouseTaxFiler>
          #             <hcore:TINIdentification>000000000</hcore:TINIdentification>
          #         </hee:SpouseTaxFiler>
          #         <hee:TaxReturnYear>2006</hee:TaxReturnYear>
          #         <hee:TaxReturnFilingStatusCode>0</hee:TaxReturnFilingStatusCode>
          #         <hee:TaxReturnAGIAmount>0.00</hee:TaxReturnAGIAmount>
          # <!--    <hee:TaxReturnMAGIAmount>0.00</hee:TaxReturnMAGIAmount> -->
          #         <hee:TaxReturnTaxableSocialSecurityBenefitsAmount>0.00</hee:TaxReturnTaxableSocialSecurityBenefitsAmount>
          #         <hee:TaxReturnTotalExemptionsQuantity>0</hee:TaxReturnTotalExemptionsQuantity>
          #     </ext:TaxReturn>
          class TaxReturn < Dry::Struct
            # Household Income Amount is the aggregate income of all individuals
            #   listed on the application and provided in the request to IRS.
            #   The household aggregate income includes a combined (joint) tax
            #   filer/spouse income if the tax filer/spouse filed a joint tax return
            # @return [Types::Money]
            attribute :fti_household_income_amount,
                      AcaEntities::Types::Money.meta(omittable: false)

            # SSN for each individual provided in the request for whom tax
            #   data is requested
            attribute :fti_primary_tax_filer_id,
                      Types::String.meta(omittable: true)

            # Identifies the spouse's SSN on a married filing joint tax return
            #   when both individuals are applicants
            attribute :fti_spouse_tax_filer_id,
                      Types::String.meta(omittable: true)

            # Return-level Income is provided for returns found by IRS for tax
            #   filers included in the request.
            attribute :fti_tax_return_magi_amount,
                      AcaEntities::Types::Money.meta(omittable: true)

            # Identifies AGI for each adjusted return.
            # Note: AGI will not be included in the (Household) Income Amount.
            attribute :fti_tax_return_agi_amount,
                      AcaEntities::Types::Money.meta(omittable: true)

            # Identifies the amount of taxable Social Security benefits included
            #  in the individual's Tax Return Income Amount
            # Note: Tax Return Taxable Social Security Benefits Amount is not
            #   provided for adjusted returns.
            attribute :fti_tax_return_taxable_social_security_benefits_amount,
                      AcaEntities::Types::Money.meta(omittable: true)

            # Identifies the tax year for which IRS is providing data. Typically,
            #   this is be the most recent tax year available for the individual.
            #   If a return is unavailable for the "second preceding tax year"
            #   (e.g., 2012), then the "second preceding tax year minus one"
            #   (e.g., 2011) may be returned, if available. (In other words,
            #   most recent year or second most recent year filed.)
            attribute :fti_tax_return_year,
                      Fdsh::Ifsv::H9t::Types::TaxReturnYearType.meta(
                        omittable: false
                      )

            # Identifies the filing status of the individual(s) who filed the return
            attribute :fti_tax_return_filing_status_code,
                      Fdsh::Ifsv::H9t::Types::TaxReturnFilingStatusCode.meta(
                        omittable: true
                      )

            # The number of exemptions is used to define the family size. If IRS
            #   locates a tax return for a dependent on an application and the
            #   number of exemptions is one, then it can be assumed that the dependent
            #   is not listed as the dependent on another tax return. If the number
            #   of exemptions on the dependent's return is zero, then it can be
            #   assumed that the dependent is listed as a dependent on someone
            #   else's return, but IRS cannot determine who claimed the dependent
            #   on his/her return
            attribute :fti_tax_return_total_exemptions_quantity,
                      Types::Integer.meta(omittable: false)
          end
        end
      end
    end
  end
end
