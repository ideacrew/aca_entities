# frozen_string_literal: true

module Iap
  class Application < Dry::Struct

    # FFM Attributes
    # Application ID
    # Identification Category Text
    # Application Signature Date
    # Original Signature Date
    # Application Creation Date
    # Application Update Date
    # Applying for Financial Assistance Indicator
    # Medicaid Determination Indicator
    # Privacy Policy Agreement Indicator
    # Attested Not Incarcerated Indicator
    # Pending Disposition
    # Attested If Information Changes Indicator
    # Attested Medicaid Applicant Awareness Indicator
    # Attested Non Perjury Indicator
    # Attested To Cooperate With Medical Collection Agency
    # Tax Return Access Indicator
    # Tax Return Access

    attribute :hbx_id, Types::String.meta(omittable: false)
    attribute :submitted_on, Types::Date.meta(omittable: false)
    attribute :created_at, Types::Date.meta(omittable: false)
    attribute :is_applying_for_assistance, Types::Bool.meta(omittable: false)

    # Indicates applicant understands how information will be used.
    attribute :medicaid_terms, Types::Bool.optional.meta(omittable: true)

    # Indicates the applicant agrees to inform FFE of changes to application.
    attribute :report_change_terms, Types::Bool.meta(omittable: false)

    # Indicates the applicant has attested that he/she is aware of Medicaid obligations.
    attribute :medicaid_insurance_collection_terms, Types::Bool.optional.meta(omittable: true)

    # Indicates the applicant attests that the information provided is truthful.
    attribute :submission_terms, Types::Bool.meta(omittable: false)

    # Indicates the applicant agrees to cooperate with agencies that collection medical
    # support information from absent parents.
    attribute :attestation_terms, Types::Bool.optional.meta(omittable: true)

    # Indicates applicant agrees to allow FFE access to his tax returns.
    attribute :is_renewal_authorized, Types::Bool.meta(omittable: false)

    # Applicant grants access to tax return information in future yearsValues include: 1,2,3,4,5 (years).
    attribute :years_to_renew, Types::Integer.optional.meta(omittable: true)
  end
end
