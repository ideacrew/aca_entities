class Family
  include Mongoid::Document
  include Determinable::Eligibility

  eligibility :aca_individual_market_eligibility,
              subject: {
                family_member: {
                  class_name: 'Family::FamilyMember'
                }
              },
              evidences: {
                immigration_status: {
                  class_name: 'Person',
                  visitor: {
                    name: :AcaIndividualMarketEligibilityVisitor,
                    class_name: 'Eligibilities::Visitors::AcaIndividualMarketEligibilityVisitor'
                  },
                  options: {}
                },
                citizenship: {
                  class_name: 'Person',
                  visitor: nil,
                  options: {}
                },
                american_indian_status: {
                  class_name: 'Person',
                  options: {}
                },
                social_security_number: {
                  class_name: 'Person',
                  options: {}
                }
              },
              grants: {
                aptc_premium_adjustment_grant: {
                  class_name: ''
                },
                csr_grant: {
                  class_name: ''
                }
              },
              dependencies: {},
              determinations: {
                determination: {
                  determined_at: Time.now,
                  effective_on: Date.today
                }
              },
              options: {}
end
