# frozen_string_literal: true

module AcaEntities
  module Contracts
    module Documents
      # Schema and validation rules for {AcaEntities::Documents::Document}
      class DocumentContract < Dry::Validation::Contract
        # @!method call(opts)
        # @param [Hash] opts the parameters to validate using this contract
        # @option opts [String] :title required
        # @option opts [String] :creator optional
        # @option opts [String] :subject optional
        # @option opts [String] :description required
        # @option opts [String] :publisher optional
        # @option opts [String] :contributor optional
        # @option opts [Date] :date optional
        # @option opts [String] :type optional
        # @option opts [String] :format optional
        # @option opts [String] :identifier optional
        # @option opts [String] :source optional
        # @option opts [String] :language required
        # @option opts [String] :relation optional
        # @option opts [String] :coverage required
        # @option opts [String] :rights optional
        # @option opts [Array] :tags optional
        # @option opts [String] :size optional
        # @return [Dry::Monads::Result]
        params do
          required(:title).filled(:string)
          required(:creator).filled(:string)
          required(:subject).filled(:string)
          optional(:description).maybe(:string)
          required(:publisher).filled(:string)
          optional(:contributor).maybe(:string)
          optional(:date).maybe(:date)
          required(:type).filled(:string)
          required(:format).filled(:string)
          optional(:identifier).maybe(:string)
          required(:source).filled(:string)
          required(:language).filled(:string)
          optional(:relation).maybe(:string)
          optional(:coverage).maybe(:string)
          optional(:rights).maybe(
            AcaEntities::Types::DocumentRights
          )
          optional(:tags).maybe(:array)
          optional(:size).maybe(:string)
        end

        rule(:rights) do
          if key? && values[:rights]
            key.failure('Not a valid document right') unless DocumentRights.include?(values[:rights])
          end
        end
      end
    end
  end
end
