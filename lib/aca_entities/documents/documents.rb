# frozen_string_literal: true

module AcaEntities
  module Transitions
    require_relative 'contracts/document_contract'
    require_relative 'contracts/ridp_document_contract'
    require_relative 'contracts/vlp_document_contract'

    require_relative 'document'
    require_relative 'ridp_document'
    require_relative 'vlp_document'
  end
end
