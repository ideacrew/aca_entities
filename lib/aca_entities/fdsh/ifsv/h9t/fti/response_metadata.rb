# frozen_string_literal: true

module AcaEntities
  module Fdsh
    module Ifsv
      module H9t
        # FTI Response Top Level Namespace
        class FtiResponseMetadata < Dry::Struct
          attribute :response_code, Types::String
          attribute :response_description_text, Types::String
          attribute :tds_response_description_text, Types::String
        end
      end
    end
  end
end
