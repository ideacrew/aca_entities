# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        class FtiApplicantVerification < Dry::Struct
          attribute :fti_tax_return,
                    AcaEntities::Fdsh::Ifsv::H3::FtiTaxReturn.meta(
                      omittable: false
                    )
        end
      end
    end
  end
end
