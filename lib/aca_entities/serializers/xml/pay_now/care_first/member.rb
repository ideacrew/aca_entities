# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module PayNow
        module CareFirst
          # Happymapper implementation for Member.
          class Member
            include HappyMapper

            tag 'Member'

            element :exchange_assigned_member_id, String, tag: "exchange_assigned_member_id"
            has_one :member_name, MemberName
            element :birth_date, String, tag: "birth_date"
            element :sex, String, tag: "sex"
            element :ssn, String, tag: "ssn"
            element :relationship, String, tag: "relationship"
            element :is_subscriber, Boolean, tag: "is_subscriber"

            def self.domain_to_mapper(member)
              mapper = self.new
              mapper.exchange_assigned_member_id = member.exchange_assigned_member_id
              mapper.member_name = MemberName.domain_to_mapper(member.member_name)
              mapper.birth_date = member.birth_date
              mapper.sex = member.sex
              mapper.ssn = member.ssn
              mapper.relationship = member.relationship
              mapper.is_subscriber = member.is_subscriber
              mapper
            end
          end
        end
      end
    end
  end
end