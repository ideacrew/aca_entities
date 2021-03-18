# frozen_string_literal: true

module Ehs
  class Verifications::ResidencyContract < Ehs::ApplicationContract
    params do
      required(:residency_status).filled(:string)
    end

    rule(:residency_status) do
      key.failure(text: 'invalid residency_status') if key? && value && !Types::ResidencyStatusKind.include?(value)
    end
  end
end
