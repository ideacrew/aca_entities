# frozen_string_literal: true

require "happymapper"

require_relative 'ifsv/h9t/spouse_tax_filer'
require_relative 'ifsv/h9t/primary_tax_filer'
require_relative 'ifsv/h9t/tax_return'
require_relative 'ifsv/h9t/dependent_verification'
require_relative 'ifsv/h9t/applicant_verification'
require_relative 'ifsv/h9t/income'
require_relative 'ifsv/h9t/household'
require_relative 'ifsv/h9t/irs_response'
require_relative 'ifsv/h9t/response_meta_data'
require_relative 'ifsv/h9t/error_message_detail'
require_relative 'ifsv/h9t/error_message'
require_relative 'ifsv/h9t/response'
require_relative 'ifsv/h9t/person_ssn_identification'
require_relative 'ifsv/h9t/person_name'
require_relative 'ifsv/h9t/person'
require_relative 'ifsv/h9t/ifsv_applicant'
require_relative 'ifsv/h9t/request'

# operations


module AcaEntities
  module Serializers
    module Xml
      module Fdsh
        # XML serialization for IFSV objects.
        module Ifsv
        end
      end
    end
  end
end