# frozen_string_literal: true

module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        module Pvc
          module Dmf
            module Response
              module Record
                # Represents the SSA Verification Supplement information in the FDSH PVC DMF Response domain.
                # This class includes methods for mapping domain objects to HappyMapper elements and converting them to hash representations.
                #
                # @!attribute [rw] death_confirmation_code
                #   @return [String] the death confirmation code indicating the verification status of a person's death
                class SSAVerificationSupplement
                  include HappyMapper
                  register_namespace 'ext', 'http://pvcdmfresp.ee.sim.dsh.cms.hhs.gov/extension/1.0'
                  register_namespace 'hix-core', 'http://hix.cms.gov/0.1/hix-core'

                  tag 'SSAVerificationSupplement'
                  namespace 'ext'

                  element :death_confirmation_code, String, tag: 'DeathConfirmationCode', namespace: 'hix-core'

                  # Maps domain objects to HappyMapper elements.
                  #
                  # @param response [Object] the response object containing death confirmation code
                  # @return [SSAVerificationSupplement] the mapper object with death confirmation code set
                  def self.domain_to_mapper(response)
                    mapper = self.new
                    mapper.death_confirmation_code = response.death_confirmation_code
                    mapper
                  end

                  # Converts the SSAVerificationSupplement object to a hash representation.
                  #
                  # @return [Hash] the hash representation of the SSAVerificationSupplement object
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