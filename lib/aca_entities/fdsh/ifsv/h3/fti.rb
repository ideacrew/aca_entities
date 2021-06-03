# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # General Response structure
        # IRSResponse
        #   RequestID
        #   Household
        #     IncomeAmount
        #     ApplicantVerification
        #       TaxReturn
        #         PrimaryTaxFiler
        #           TINIdentification
        #       ResponseMetadata
        #         ResponseCode
        #         ResponseDesctriptionText
        #     DependentVerification
        #       TaxReturn
        #         PrimaryTaxFiler
        #           TINIdentification
        #       ResponseMetadata
        #         ResponseCode
        #         ResponseDesctriptionText
        #
        ## FDSH IRS Transaction Tables.  Data attribute names and values are stored
        ## in native form as described in Verify Annual Household Income and Family
        ## Size (IFSV) Business Service Definition (BSD), Version 10.1 dated July 2016
        # Table Fdsh::Transactions::Irs::Requests # HBX-initiatiated request history
        # Table Fdsh::Transactions::Irs::FtiResponses # IRS response payload history
        #
        ## Income Verification Table
        # Table IncomeVerifications::Irs::FtiIncomeVerifications
        #   id # DB-assigned key
        #   hbx_id # HBX-assigned ID
        #   fdsh_request_ids # Array of Fdsh::Transactions::Irs::Requests::RequestID
        #   # HBX Request attributes
        #   person_ssn_identification # SSN store in encrypted form
        #   person_given_name # Applicant first name
        #   person_middle_name  # Person Middle Name or Initial
        #   person_sur_name # Applicant last name
        #   tax_filer_category_code # primary, spouse, dependent
        #   verification_state # State machine Flag indicating status of the income verification
        #   # Summary IRS response FTI attributes
        #   fti_tax_return_year # year tax return was filed
        #   fti_household_income_amount # Total income calculated for household
        #   created_at # DateTime record created
        #   updated_at # DateTime of last record update
        #   updated_by # Account ID of system process or user who last edited record
        #
        ## Income Verification Tax Filers Table
        # Table IncomeVerifications::Irs::FtiTaxFilers
        #   id # DB-assigned key
        #   fdsh_transactions_irs_fti_response_id # Join key to Fdsh::Transactions::Irs::FtiResponse table
        #   fti_income_verification_id # Join key to IncomeVerifications::Irs::FtiIncomeVerifications table
        #   fti_tax_filer_id # Tax ID stored in encrypted form
        #   fti_category_code
        #   fti_tax_return_year # Identifies the tax year for which IRS is providing data.
        #   fti_agi_amount # Identifies AGI for each adjusted return
        #   fti_magi_amount # Return-level Income is provided for returns found by IRS for tax filers included in the request.
        #   fti_taxable_social_security_benefits_amount  # Identifies the amount of taxable Social Security benefits included in the individual’s Tax Return Income Amount
        #   fti_filing_status_code # # Identifies the filing status of the individual(s) who filed the return
        #   fti_total_exemptions_quantity # The number of exemptions is used to define the family size
        #   fti_individual_response_code # IRS returns code(s) when a specific account condition exists and/or when certain information is not available for an individual
        #   fti_individual_reponse_description_text #  IRS returns description(s) to explain an account condition or to identify why certain information is not available for an individual
        #   requested_at # DateTime timestamp from FDSH request transaction
        #   created_at # DateTime record created
        #   updated_at # DateTime of last record update
        #   updated_by # Account ID of system process or user who last edited record
      end
    end
  end
end
