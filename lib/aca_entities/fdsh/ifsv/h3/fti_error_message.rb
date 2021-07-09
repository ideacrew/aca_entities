# frozen_string_literal: true

module Fdsh
  module Ifsv
    module H3
      class FtiErrorMessage < Dry::Struct
        attribute :ErrorMessageDetail do
          attribute :ResponseMetadata,
                    AcaEntities::Fdsh::Ifsv::H3::FtiResponseMetadata.meta(
                      omittable: false
                    )
        end
      end
    end
  end
end
