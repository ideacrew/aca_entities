# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    class Relationship < Dry::Struct
      attribute :kind, Types::String
      attribute :applicant_id, Types::String
      attribute :relative_id, Types::String
    end
  end
end