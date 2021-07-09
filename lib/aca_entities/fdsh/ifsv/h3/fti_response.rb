# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H3
        # FTI Response Top Level Namespace
        class FtiResponse < Dry::Struct
          # An HBX-assigned numeric ID that uniquely identifies the request
          #   within a given message (both requests and responses)
          #   1-9 characters - numeric only
          # @return [Types::Fdsh::Irs::RequestIDType]
          attribute :request_id,
                    AcaEntities::Fdsh::Ifsv::H3::Types::RequestIDType.meta(
                      omittable: false
                    )

          attribute :household, Types::String

          # Aggregate income of all individuals
          #   listed on the application and provided in the request to IRS.
          #   The household aggregate income includes a combined (joint) tax
          #   filer/spouse income if the tax filer/spouse filed a joint tax return
          # @return [Types::Money]
          attribute :income_amount,
                    AcaEntities::Types::Money.meta(omittable: false)

          attribute :applicant_verifications, Types::String
          attribute :dependent_verifications, Types::String
        end
      end
    end
  end
end
