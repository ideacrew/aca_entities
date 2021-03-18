# frozen_string_literal: true

module Ehs
  module Applications
    class ProgramApplicationContract < Ehs::ApplicationContract

      params do
        optional(:source_system_key).maybe(:string)
        required(:ids).array(:hash)
        required(:program_type).filled(Ehs::Types::ProgramApplicationTypeKind)
        required(:type_code).filled(Ehs::Types::ProgramApplicationTypeCodeKind)
        required(:status).filled(Ehs::Types::ProgramApplicationStatusKind)
        required(:status_code).filled(Ehs::Types::ProgramApplicationStatusCodeKind)
        required(:last_updated_at).filled(:date_time)
        required(:request_date).filled(:date)
      end
    end
  end
end
