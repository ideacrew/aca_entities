# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        class FtiVerification < Dry::Struct
          attribute :fti_household, AcaEntities::Types::String
          attribute :fti_record, AcaEntities::Types::String

          attribute :fti_tax_filer_category_code,
                    AcaEntities::Fdsh::Ifsv::H9t::Types::TaxFilerCategoryCodeKind
                      .meta(omittable: false)
          attribute :fti_tax_return_year,
                    AcaEntities::Types::Integer.meta(omittable: false)
          attribute :fti_tax_return_agi_amount,
                    AcaEntities::Types::Money.meta(omittable: false)
          attribute :fti_tax_return_magi_amount,
                    AcaEntities::Types::Money.meta(omittable: false)
          attribute :fti_tax_return_taxable_social_security_benefits_amount,
                    AcaEntities::Types::Money.meta(omittable: false)
          attribute :fti_tax_return_filing_status_code,
                    AcaEntities::Fdsh::Ifsv::H9t::Types::TaxReturnFilingStatusCodeKind
                      .meta(omittable: false)
          attribute :fti_tax_return_total_exemptions_quantity,
                    AcaEntities::Types::Integer.meta(omittable: false)
          attribute :fti_individual_response_code, AcaEntities::Types::String
          attribute :fti_individual_tds_response_description_text,
                    AcaEntities::Types::String.meta(omittable: false)

          attribute :timestamp, AcaEntities::TimeStamp.meta(omittable: true)
          attribute :updated_by,
                    AcaEntities::Accounts::User.meta(omittable: true)
        end
      end
    end
  end
end
