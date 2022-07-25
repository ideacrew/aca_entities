# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Saml
        class Primary
          include HappyMapper

          tag 'Primary'

          element :exchange_assigned_member_id, String

          has_one :member_name, MemberName

          def self.domain_to_mapper(request)
            mapper = self.new
            mapper.exchange_assigned_member_id = request.exchange_assigned_member_id
            mapper.member_name = MemberName.domain_to_mapper(request.member_name)

            mapper
          end
        end
      end
    end
  end
end