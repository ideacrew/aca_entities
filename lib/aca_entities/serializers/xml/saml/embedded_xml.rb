# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Saml
        class EmbeddedXml
          include HappyMapper

          tag 'EmbeddedXml'

          element :coverage_kind, String

          has_one :primary, Primary

          has_many :members, Member

          def self.domain_to_mapper(request)
            mapper = self.new
            mapper.coverage_kind = request.coverage_kind
            mapper.primary = Primary.domain_to_mapper(request.primary)
            mapper.members = request.members.map {|r| Member.domain_to_mapper(r)}

            mapper
          end
        end
      end
    end
  end
end