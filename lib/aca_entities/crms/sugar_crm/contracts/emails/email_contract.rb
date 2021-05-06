module AcaEntities
  module Crms
    module SugarCrm
      module Emails
        # contract for sugar_crm Emails
        class EmailContract < ApplicationContract
          params do
            optional(:email_address).maybe(:string)
            optional(:invalid_email).maybe(:bool)
            optional(:opt_out).maybe(:bool)
            optional(:primary_address).maybe(:bool)
            optional(:reply_to_address).maybe(:bool)
          end
        end
      end
    end
  end
end