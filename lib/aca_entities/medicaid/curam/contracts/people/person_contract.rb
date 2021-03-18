# frozen_string_literal: true

module Ehs
  class People::PersonContract < Ehs::ApplicationContract
    params do
      optional(:source_system_key).maybe(:string)
      required(:identifiers).array(:hash)
      optional(:ssn).maybe(:string)
      required(:gender).filled(:string)
      required(:date_of_birth).filled(:date)
      required(:person_name).filled(:hash)
      required(:last_updated_at).filled(:date_time)
    end

    rule(:identifiers) do 
      if key? && value  
        key.failure(text: "Only one identifier should be of key: #{Types::PrimaryKeyKind}") if value.select {|each_id| each_id[:key] == Types::PrimaryKeyKind}.count > 1  
        identifiers_array = value.inject([]) do |hash_array, id_hash| 
                            if id_hash.is_a?(Hash)  
                              result = Identifiers::IdContract.new.call(id_hash)  
                              if result&.failure? 
                                key.failure(text: 'invalid identifier', error: result.errors.to_h)  
                              else  
                                hash_array << result.to_h 
                              end 
                            else  
                              key.failure(text: 'invalid identifier. Expected a hash.') 
                            end 
                            hash_array  
                          end 
        values.merge!(identifiers: identifiers_array) 
      end 
    end

    rule(:gender) do
      key.failure(text: 'invalid gender') if key? && value && !Types::GenderKinds.include?(value)
    end

    rule(:person_name) do
      if key? && value
        if value.is_a?(Hash)
          result = People::PersonNameContract.new.call(value)
          if result&.failure?
            key.failure(text: 'invalid person name', error: result.errors.to_h)
          else
            values.merge!(person_name: result.to_h)
          end
        else
          key.failure(text: 'invalid person name. Expected a hash.')
        end
      end
    end
  end
end
