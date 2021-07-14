# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # A relationship A data type for a relationship between an employer and an employee.
          class PersonEmploymentAssociation
            include HappyMapper

            tag 'PersonEmploymentAssociation'
            namespace 'hix-core'

            has_one :begin_date, AssociationBeginDate
            has_one :end_date, AssociationEndDate
            has_one :employer, Employer

            def self.domain_to_mapper(employment_association)
              mapper = self.new
              mapper.employer = Employer.domain_to_mapper(employment_association.employer)
              mapper
            end

            def to_hash
              {
                begin_date: begin_date&.to_hash,
                end_date: end_date&.to_hash,
                employer: employer&.to_hash
              }
            end
          end
        end
      end
    end
  end
end