# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Applications
        # contract for ProgramApplicationC
        class ProgramApplicationContract < Curam::ApplicationContract

          params do
            optional(:source_system_key).maybe(:string)
            required(:ids).array(:hash)
            required(:program_type).filled(Curam::TypesProgramApplicationTypeKind)
            required(:type_code).filled(Curam::TypesProgramApplicationTypeCodeKind)
            required(:status).filled(Curam::TypesProgramApplicationStatusKind)
            required(:status_code).filled(Curam::TypesProgramApplicationStatusCodeKind)
            required(:last_updated_at).filled(:date_time)
            required(:request_date).filled(:date)
          end
        end
      end
    end
  end
end
