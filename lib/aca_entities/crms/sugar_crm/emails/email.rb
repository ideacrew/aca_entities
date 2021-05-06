# frozen_string_literal: true

module AcaEntities
  module Crms
    module SugarCrm
      module Emails
        # entity for sugar_crm Emails
        class Email < Dry::Struct

          attribute :email_address,          Types::Strict::String.meta(omittable: true)
          attribute :invalid_email,          Types::Bool.meta(omittable: true)
          attribute :opt_out,                Types::Bool.meta(omittable: true)
          attribute :primary_address,        Types::Bool.meta(omittable: true)
          attribute :reply_to_address,       Types::Bool.meta(omittable: true)
        end
      end
    end
  end
end