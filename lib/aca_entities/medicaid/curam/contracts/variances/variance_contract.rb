# frozen_string_literal: true

module Ehs
  class Variances::VarianceContract < Ehs::ApplicationContract
    
    params do
      required(:title).filled(:string)
      optional(:description).maybe(:string)
      required(:status).filled(:string)
      required(:status_result).filled(:string)
      required(:severity).filled(:string)
      optional(:assigned_to).maybe(:string)
      optional(:updated_by).maybe(:string)
      optional(:review_status).maybe(:string)
    end
  end
end
