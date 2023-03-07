# frozen_string_literal: true

module AcaEntities
  module PayNow
    module CareFirst
      module Transformers
        # Transformer for PayNow CareFirst custom XML
        class CoverageAndMembers < ::AcaEntities::Operations::Transforms::Transform
          include ::AcaEntities::Operations::Transforms::Transformer

          namespace 'coverage_and_members' do
            rewrap 'pay_now_transfer_payload', type: :hash do

              map 'hbx_enrollment.product_kind', 'coverage_kind', function: lambda { |v|
                "urn:openhbx:terms:v1:qhp_benefit_coverage##{v}"
              }

              # TODO: primary
              # TODO: members
            end
          end
        end
      end
    end
  end
end
