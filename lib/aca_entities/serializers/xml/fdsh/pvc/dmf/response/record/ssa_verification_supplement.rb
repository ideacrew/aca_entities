# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                class SSAVerificationSupplement
                  include HappyMapper
                  register_namespace 'ext', 'http://pvcdmfresp.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                  register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                  tag 'SSAVerificationSupplement'
                  namespace 'ext'

                  element :death_confirmation_code, String, tag: 'DeathConfirmationCode', namespace: 'hix-core'

                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.death_confirmation_code = response.death_confirmation_code
                    mapper
                  end

                  def to_hash
                    {
                      DeathConfirmationCode: death_confirmation_code
                    }
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end