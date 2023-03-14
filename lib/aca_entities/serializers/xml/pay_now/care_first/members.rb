# frozen_string_literal: true

module AcaEntities
    module Serializers
      module Xml
        module PayNow
          module CareFirst
            # Happymapper implementation for Member.
            class Members
              include HappyMapper
  
              tag 'members'

              has_many :members, Member
  
              def self.domain_to_mapper(members)
                mapper = self.new
                mapper.members = members.map do |member|
                    Member.domain_to_mapper(member)
                end
                mapper
              end
            end
          end
        end
      end
    end
  end