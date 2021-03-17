# frozen_string_literal: true

# module AcaEntities
module AcaEntities
  # Contract for Verification
  class VerificationContract < Dry::Validation::Contract

    params do
      optional(:verification_header).maybe(:hash)
      optional(:ssa_information).maybe(:hash)
      optional(:dhs_save).maybe(:hash)
      optional(:tax_household_annual_income).maybe(:hash)
      optional(:basis_for_outcome).maybe(:hash)
      optional(:address).maybe(:hash)
    end
  end

  rule(:verification_header) do
    if key? && value
      if value.is_a?(Hash)
        result = VerificationHeaderContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid verification header', error: result.errors.to_h)
        else
          values.merge!(verification_header: result.to_h)
        end
      else
        key.failure(text: 'invalid verification header. Expected a hash.')
      end
    end
  end

  rule(:ssa_information) do
    if key? && value
      if value.is_a?(Hash)
        result = SsaInformationContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid ssa information', error: result.errors.to_h)
        else
          values.merge!(ssa_information: result.to_h)
        end
      else
        key.failure(text: 'invalid ssa information. Expected a hash.')
      end
    end
  end

  rule(:dhs_save) do
    if key? && value
      if value.is_a?(Hash)
        result = DhsSaveContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid dhs save', error: result.errors.to_h)
        else
          values.merge!(dhs_save: result.to_h)
        end
      else
        key.failure(text: 'invalid dhs save. Expected a hash.')
      end
    end
  end

  rule(:tax_household_annual_income) do
    if key? && value
      if value.is_a?(Hash)
        result = TaxHouseholdAnnualIncomeContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid tax household annual income', error: result.errors.to_h)
        else
          values.merge!(tax_household_annual_income: result.to_h)
        end
      else
        key.failure(text: 'invalid tax household annual income. Expected a hash.')
      end
    end
  end

  rule(:basis_for_outcome) do
    if key? && value
      if value.is_a?(Hash)
        result = BasisForOutcomeContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid basis for outcome', error: result.errors.to_h)
        else
          values.merge!(basis_for_outcome: result.to_h)
        end
      else
        key.failure(text: 'invalid basis for outcome. Expected a hash.')
      end
    end
  end

  rule(:address) do
    if key? && value
      if value.is_a?(Hash)
        result = AddressContract.new.call(value)
        if result&.failure?
          key.failure(text: 'invalid address', error: result.errors.to_h)
        else
          values.merge!(address: result.to_h)
        end
      else
        key.failure(text: 'invalid address. Expected a hash.')
      end
    end
  end
end
