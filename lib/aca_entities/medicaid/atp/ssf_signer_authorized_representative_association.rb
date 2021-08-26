# frozen_string_literal: true

module AcaEntities
  module Medicaid
    module Atp
      # entity for atp SsfSignerAuthorizedRepresentativeAssociation
      class SsfSignerAuthorizedRepresentativeAssociation < Dry::Struct
        attribute :signature,                            Signature.meta(omittable: false)
        attribute :authorized_representative_reference,  AuthorizedRepresentativeReference.optional.meta(omittable: true)
      end
    end
  end
end