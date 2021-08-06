# frozen_string_literal: true

module Fdsh
  module Ifsv
    module H9t
      module Api
        class ErrorMessage < Dry::Struct
          attribute :ErrorMessageDetail do
            attribute :ResponseMetadata,
                      AcaEntities::Fdsh::Ifsv::H9t::Api::ResponseMetadata.meta(
                        omittable: false
                      )
          end
        end
      end
    end
  end
end
