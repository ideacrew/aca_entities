# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        module FtiResponses
          # Response data elements the IRS submits to the Requester via the Hub
          class Response
            # An HBX-assigned  numeric ID that uniquely identifies the request
            #   within a given message (both requests and responses)
            #   1-9 characters - numeric only
            # @return [Types::Fdsh::Irs::RequestIDType]
            attribute :"RequestID",
                      Types::Fdsh::Ifsv::H3::RequestIDType.meta(
                        omittable: false
                      )

            # Household Income Amount is the aggregate income of all individuals
            #   listed on the application and provided in the request to IRS.
            #   The household aggregate income includes a combined (joint) tax
            #   filer/spouse income if the tax filer/spouse filed a joint tax return
            # @return [Types::Money]
            attribute :"HouseholdIncomeAmount",
                      Types::Money.meta(omittable: false)

            # SSN for each individual provided in the request for whom tax
            #   data is requested
            attribute :"PrimaryTaxFiler", Types::String.meta(omittable: true)

            # Return-level Income is provided for returns found by IRS for tax
            #   filers included in the request.
            attribute :"TaxReturnMAGIAmount", Types::Money.meta(omittable: true)

            # Identifies AGI for each adjusted return.
            # Note: AGI will not be included in the (Household) Income Amount.
            attribute :"TaxReturnAGIAmount", Types::Money.meta(omittable: true)

            # Identifies the amount of taxable Social Security benefits included
            #  in the individual’s Tax Return Income Amount
            # Note: Tax Return Taxable Social Security Benefits Amount is not
            #   provided for adjusted returns.
            attribute :"TaxReturnTaxableSocialSecurityBenefitsAmount",
                      Types::Money.meta(omittable: true)

            # Identifies the tax year for which IRS is providing data. Typically,
            #   this is be the most recent tax year available for the individual.
            #   If a return is unavailable for the “second preceding tax year”
            #   (e.g., 2012), then the “second preceding tax year minus one”
            #   (e.g., 2011) may be returned, if available. (In other words,
            #   most recent year or second most recent year filed.)
            attribute :"TaxReturnYear",
                      Types::Fdsh::Ifsv::H3::TaxReturnYearType.meta(
                        omittable: true
                      )

            # Identifies the filing status of the individual(s) who filed the return
            attribute :"TaxReturnFilingStatusCode",
                      Types::Fdsh::Ifsv::H3::TaxReturnFilingStatusCode.meta(
                        omittable: true
                      )

            # Identifies the spouse’s SSN on a married filing joint tax return
            #   when both individuals are applicants
            attribute :"SpouseTaxFiler", Types::String.meta(omittable: true)

            # The number of exemptions is used to define the family size. If IRS
            #   locates a tax return for a dependent on an application and the
            #   number of exemptions is one, then it can be assumed that the dependent
            #   is not listed as the dependent on another tax return. If the number
            #   of exemptions on the dependent’s return is zero, then it can be
            #   assumed that the dependent is listed as a dependent on someone
            #   else’s return, but IRS cannot determine who claimed the dependent
            #   on his/her return
            attribute :"TaxReturnTotalExemptionsQuantity",
                      Types::Integer.meta(omittable: true)

            # IRS returns code(s) when a specific account condition exists and/or
            #   when certain information is not available for an individual
            attribute :"IndividualResponseCode",
                      Types::String.meta(omittable: true)

            #  IRS returns description(s) to explain an account condition or to
            #   identify why certain information is not available for an individual
            attribute :"IndividualResponseDescriptionText",
                      Types::String.meta(omittable: true)

            # A description of a response received from IRS for which a code was not
            #   previously provided
            attribute :"IndividualTDSResponseDescriptionText",
                      Types::String.meta(omittable: true)

            # IRS returns a code to the Requester if the request cannot be completed
            #   because of errors
            attribute :"MessageResponseCode",
                      Types::String.meta(omittable: true)

            #  IRS returns a message description to the Requester that corresponds
            #   to the message response code if the request cannot be completed
            #   because of errors
            attribute :"MessageResponseDescriptionText",
                      Types::String.meta(omittable: true)

            # A description of a response received from IRS for which a code was
            #   not previously provided
            attribute :"MessageTDSResponseDescriptionText",
                      Types::String.meta(omittable: true)

            # The XPath of the specific element/attribute within the XML
            #   request/response data
            attribute :"XPathContent", Types::String.meta(omittable: true)
          end
        end
      end
    end
  end
end
