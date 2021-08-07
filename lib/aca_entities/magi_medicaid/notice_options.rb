# frozen_string_literal: true

module AcaEntities
  module MagiMedicaid
    # Entity for Application NoticeOptions.
    class NoticeOptions < Dry::Struct
      attribute :send_eligibility_notices, Types::Bool.meta(omittable: false)
      attribute :send_open_enrollment_notices, Types::Bool.meta(omittable: false)
    end
  end
end
