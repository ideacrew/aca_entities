# frozen_string_literal: true

module AcaEntities
  module EventLogs
    # Entity for Session Detail
    class SessionDetail < Dry::Struct

      attribute :session_id, Types::String.optional.meta(omittable: false)
      attribute :login_session_id, Types::String.optional.meta(omittable: false)
      attribute :portal, Types::String.optional.meta(omittable: false)
    end
  end
end
