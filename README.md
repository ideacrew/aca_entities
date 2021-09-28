# AcaEntities

A portable domain model for Benefit Management solutions.

IdeaCrew defines a Canonical Vocabulay (CV) for structuring and
exchanging information between services for its benefit management
technology solutions. AcaEntities defines those domain model entities,
validation contracts, transformations with other vocabularies, and
other supporting artifacts.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aca_entities'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install aca_entities

## Usage

AcaEntities is organized into a series of subject-area libraries that load only
the artifacts and dependencies associated with that subject. Each library includes
a ruby file for the namespace that requires all the depenencies for that library.

For example, {AcaEntities::Fdsh::Fdsh.rb} requires all dependencies to load the
FDSH namespace.

AcaEntities includes the following libraries:

### {AcaEntities::Configuration::Encryption Encryption}

Configuration setup to Encrypt and Decrypt sensitive information.

Initializer file in other Applications(Rails App)

```
AcaEntities::Configuration::Encryption.configure do |config|
    config.encrypted_key = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_KEY']
    config.encrypted_iv = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_IV']
    config.private_rsa_key = ENV['ENROLL_SYMMETRIC_ENCRYPTION_PRIVATE_KEY']
    config.app_env = Rails.env
end
```

Operations to Encrypt and Decrypt

Encrypt - `AcaEntities::Operations::SymmetricEncryption::Encrypt`

Decrypt - `AcaEntities::Operations::SymmetricEncryption::Decrypt`

### {AcaEntities::Atp ATP}

Vocabularies and transforms that enable account and eligibility information exchange
between FFE Account Transfer Protocol (ATP) and IdeaCrew's CV.

### {AcaEntities::AsynApi AsynApi}

Interface definitions for service producers and consumers to exchange messages.
Typically used by the {https://github.com/ideacrew/aca_entities.git EventSource gem}
these files follow the {https://www.asyncapi.com/docs/specifications/v2.0.0 AsyncAPI 2.0} standard.

### {AcaEntities::Crms CRMs}

Integration with Customer Relationship Management (CRM) systems including SugarCRM.

### {AcaEntities::Fdsh FDSH}

Integration with CMS's Federal Data Sharing Hub (FDSH) that supports
eligibility determination and verification services necessary to operate a
State-based Exchange (SBE).

### {AcaEntities::Google Google}

Integrations with Google Map services including interactive UI maps and
address geocoding services.

### {AcaEntities::Ledger Ledger}

Integrations with accounting services including Quickbooks Online.

### {AcaEntities::MagiMedicaid MagiMedicaid}

Integrations and code that enable Affordable Care Act (ACA) financial
assistance eligibility determinations, including MAGI Medicaid, Advance
Premium Tax Credit (APTC) and Cost Sharing Reductions (CSRs)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

AcaEnties uses {https://dry-rb.org/ dry-rb} libriries to define domain entities:
{https://dry-rb.org/gems/dry-struct/1.0/ dry-struct} and validation contracts:
{https://dry-rb.org/gems/dry-validation/1.6/ dry-validation}.

Entity definitions are flexible - nearly all define entities list each attribute as optional. Validation contracts, which can be applied based on specific scenarios,
are strict - attribute presence, coersion and type are specified at the contract
level only.

Include APi documentation and rspec specs for all entities, contracts, transforms
and other content added to AcaEntities.

### Extending AcaEntities Domain Model

Before you add new code to AcaEntties, make sure existing domain models don't already
exist for your needs. Next, determine existing core model entities that you can reuse to build out the new namespace.

### Issues

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/aca_entities. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/aca_entities/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AcaEntities project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/aca_entities/blob/master/CODE_OF_CONDUCT.md).
