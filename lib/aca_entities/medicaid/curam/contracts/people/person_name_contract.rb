# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module People
        # contract for person  name
        class PersonNameContract < Curam::ApplicationContract

          params do
            required(:first_name).filled(:string)
            required(:last_name).filled(:string)

            optional(:name_pfx).maybe(:string)
            optional(:middle_name).maybe(:string)
            optional(:name_sfx).maybe(:string)
            optional(:title).maybe(:string)
          end
        end
      end
    end
  end
end
