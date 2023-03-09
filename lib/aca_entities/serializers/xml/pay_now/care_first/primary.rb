# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for primary
          class Primary
            include HappyMapper

            tag "primary"

            element :exchange_assigned_member_id, String, tag: "exchange_assigned_member_id"
            has_one :member_name, MemberName

            def self.domain_to_mapper(primary)
              mapper = self.new
              mapper.exchange_assigned_member_id = primary.exchange_assigned_member_id
              mapper.member_name = MemberName.domain_to_mapper(primary.member_name)
              mapper
            end
          end
        end
      end
    end
  end
end
