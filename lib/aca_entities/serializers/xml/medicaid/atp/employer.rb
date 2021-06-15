# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An outgoing monetary payment.
          class Employer
            include HappyMapper
            register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'
            register_namespace 'nc', 'http://niem.gov/niem/niem-core/2.0'

            tag 'Employer'
            namespace 'hix-core'

            element :category_text, String, tag: 'OrganizationName', namespace: "nc"
            has_one :organization_primary_contact_information, OrganizationPrimaryContactInformation

            def self.domain_to_mapper(expense)
              mapper = self.new
              mapper
            end
          end
        end
      end
    end
  end
end