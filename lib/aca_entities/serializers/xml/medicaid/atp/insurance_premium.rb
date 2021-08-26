# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Medicaid
        module Atp
          # An identification assigned by a Childrens Health Insurance Program (CHIP) program to an individual.
          class InsurancePremium
            include HappyMapper

            tag 'InsurancePremium'
            namespace 'hix-ee'

            element :amount, Float, tag: 'InsurancePremiumAmount'
            element :aptc_amount, Float, tag: 'InsurancePremiumAPTCAmount'
            element :subscriber_amount, Float, tag: 'InsurancePremiumSubscriberAmount'

            def self.domain_to_mapper(premium)
              mapper = self.new
              mapper.amount = premium.amount
              mapper.aptc_amount = premium.aptc_amount
              mapper.subscriber_amount = premium.subscriber_amount
              mapper
            end

            def to_hash
              {
                amount: amount,
                aptc_amount: aptc_amount,
                subscriber_amount: subscriber_amount
              }
            end
          end
        end
      end
    end
  end
end