# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Ifsv
          module H9t
            # Happymapper implementation for the root object of an Request.
            class Household
              include HappyMapper
              register_namespace 'ext', 'http://ifsv.dsh.cms.gov/extension/1.0'

              tag 'Household'
              namespace 'ext'

              has_one :Income, Income
              has_many :ApplicantVerifications, ApplicantVerification
              has_many :DependentVerifications, DependentVerification

              def self.domain_to_mapper(response)
                mapper = self.new
                mapper.Income = Income.domain_to_mapper(response.Income)
                mapper.ApplicantVerifications = request.ApplicantVerifications.collect do |applicant_verification|
                  ApplicantVerification.domain_to_mapper(applicant_verification)
                end
                mapper.DependentVerifications = request.DependentVerifications.collect do |dependent_verification|
                  Verification.domain_to_mapper(dependent_verification)
                end
                mapper
              end
            end
          end
        end
      end
    end
  end
end