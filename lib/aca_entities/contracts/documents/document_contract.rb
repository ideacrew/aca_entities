# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Documents
      # Schema and validation rules for {AcaEntities::Documents::Document}
      class DocumentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :title optional
        # @option opts [String] :creator optional
        # @option opts [String] :subject optional
        # @option opts [String] :description optional
        # @option opts [String] :publisher optional
        # @option opts [String] :contributor optional
        # @option opts [Date] :date optional
        # @option opts [String] :type optional
        # @option opts [String] :format optional
        # @option opts [String] :identifier optional
        # @option opts [String] :source optional
        # @option opts [String] :language optional
        # @option opts [String] :relation optional
        # @option opts [String] :coverage optional
        # @option opts [String] :rights optional
        # @option opts [Array] :tags optional
        # @option opts [String] :size optional
        # @return [Dry::Monads::Result]
        params do
          optional(:title).filled(:string)
          optional(:creator).filled(:string)
          optional(:subject).filled(:string)
          optional(:publisher).filled(:string)
          optional(:source).filled(:string)
          optional(:language).filled(:string)
          optional(:type).filled(:string)
          optional(:format).filled(:string)

          optional(:description).maybe(:string)
          optional(:contributor).maybe(:string)
          optional(:date).value(:date)
          optional(:identifier).maybe(:string)
          optional(:relation).maybe(:string)
          optional(:coverage).maybe(:string)
          optional(:rights).filled(
            AcaEntities::Types::DocumentRights
          )
          optional(:tags).maybe(:array)
          optional(:size).maybe(:string)
          optional(:doc_identifier).maybe(:string)
        end
      end
    end
  end
end
