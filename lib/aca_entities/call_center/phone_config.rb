# frozen_string_literal: true

module AcaEntities
  module CallCenter

    # Define a User together with its settings, code hook for dependency injection, and configuration UI attributes
    #
    # @example Define the phone_config
    #   PhoneConfig.new()
    class PhoneConfig < Dry::Struct

      attribute :phone_type,                    CallCenter::Types::Phone.meta(omittable: false)
      attribute :auto_accept,                   Types::Bool.meta(omittable: true)
      attribute :after_contact_work_time_limit, Types::Integer.meta(omittable: true)
      attribute :desk_phone_number,             Types::String.meta(omittable: true)

    end
  end
end
