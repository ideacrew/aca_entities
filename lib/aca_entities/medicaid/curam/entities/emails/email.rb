# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Curam
      module Emails
        # curam email entity
        class Email < Dry::Struct

          attribute :type,    Types::EmailKind.meta(omittable: false)
          attribute :address, Types::String.meta(omittable: false)
        end
      end
    end
  end
end
