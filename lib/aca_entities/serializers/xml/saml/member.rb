# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Saml
        class Member
          include HappyMapper

          tag 'Member'

          element :exchange_assigned_member_id, String
          has_one :member_name, MemberName
          element :birth_date, String
          element :sex, String
          element :ssn, String
          element :relationship, String
          element :is_subscriber, Boolean

          def self.domain_to_mapper(request)
            mapper = self.new
            mapper.exchange_assigned_member_id = request.exchange_assigned_member_id
            mapper.member_name = MemberName.domain_to_mapper(request.member_name)
            mapper.birth_date = request.birth_date
            mapper.sex = request.sex
            mapper.ssn = request.ssn
            mapper.relationship = request.relationship
            mapper.is_subscriber = request.is_subscriber

            mapper
          end
        end
      end
    end
  end
end