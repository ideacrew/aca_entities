# AcaEntities

A portable Domain model for Benefit Management solutions.

IdeaCrew defines a Canonical Vocabulay (CV) for structuring and exchanging information between services for its benefit management technology solutions. AcaEntities defines those domain model entities, validation contracts, transformations with other vocabularies, and other supporting artifacts.

## Documentation

Documentation is automatically generated for both the project and the Ruby source code.

To build and view the documentation, make sure you have hugo installed (usually via `brew install hugo`) and then run:
```
bundle exec rake docserver
```

This will start a hugo documentation server you can view.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aca_entities'
```

And then execute:

```sh
$ bundle install
Bundle complete! NN Gemfile dependencies, NN gems now installed.
```

Or install it yourself as:

```sh
$ gem install aca_entities
```

## Usage

AcaEntities' canonical vocabularies help manage uniform, efficient data exchange across internal and external system services. Operations and helper features provide solutions for commonly-used data management functions. AcaEntties uses the [dry-rb](https://dry-rb.org/) gem library to support Domain-Driven Design and Clean Code tenets.

### Creating Domain Classes with `rails generate`

Rails generators are command line tools that automate the process of creating or editing files with boilerplace code. AcaEntities provides Rails generators that support Domain-driven software development.

There are three primary `domain` generators: `domain:install, domain:entity` and `domain:operation`. These tools accelerate development by creating and configuring `Entity, Contract, Operation` and `Types` classes and associated Rspec files. They manage namespaces, dependencies and declarations consistent with IdeaCrew's Clean Code conventions. They also seed `yardoc` customization-ready content to easily produce development technical documentation.

The `domain:install` generator configures a new Rails application (`domain_app` in this example) to use Domain components:

```sh
$ rails generate domain:install
      create  app/domain/contracts/contract.rb
      create  app/domain/types.rb
      create  app/domain/domain_app/types.rb
      invoke  rspec
      create    spec/domain/domain_app/types_spec.rb
```

Use the `domain:entity` generator to create Domain Entity classes and associated attributes. This generator accepts arguments for an Entity name and an optional list of attributes and creates corresponding Entity and Contract files under the `app/domain` folder. Attribute arguments include a required attribute name value, with optional type and key parameters:

```sh
ATTRIBUTE_NAME[:type][:optional_key (default) | :required_key]
```

For example:

```sh
$ rails g domain:entity organization id:integer:required_key description:string name:string submitted_at:date_time
      create  app/domain/organization.rb
    generate  domain:contract
       rails  generate domain:contract organization id:integer:required_key description:string name:string submitted_at:date_time
      create  app/domain/contracts/organization_contract.rb
      invoke  rspec
      create    spec/domain/contracts/organization_contract_spec.rb
      invoke  rspec
      create    spec/domain/organization_spec.rb
```

Use the `domain:operation` generator to create an Operation class under the `app/operations` folder. Operations are named in imperative form as they function as commands or actions. Since Operations often publish an Event, the generated file includes references to EventSource dependencies. For example:

```sh
rails g domain:operation create_organization
      create  app/operations/create_organization.rb
      invoke  rspec
      create    spec/operations/create_organization_spec.rb
```

**Note:** executing `$ rails generate --help` on the command line will list all available generators.

### Protecting Sensitive Data Using Symmetic Encryption

AcaEntities includes encrypt/decrypt functions to encode PII and other senstive data content for transmission between services and for persisting to data stores. Applications and services can access this feature in two steps.

First, add or extend an AcaEntities initialize file (`config/initializers/aca_entities.rb`) with secure key configuration

```ruby
# config/initializers/aca_entities.rb

AcaEntities::Configuration::Encryption.configure do |config|
  config.encrypted_key = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_KEY']
  config.encrypted_iv = ENV['SYMMETRIC_ENCRYPTION_ENCRYPTED_IV']
  config.private_rsa_key = ENV['ENROLL_SYMMETRIC_ENCRYPTION_PRIVATE_KEY']
  config.app_env = Rails.env
end
```

Second, call the appropriate Operation, passing data to be encrypted or decypted:

```ruby
encrypted_value = AcaEntities::Operations::Encryption::Encrypt(sensitive_data)
decrypted_value = AcaEntities::Operations::Encryption::Decrypt(encrypted_value)
```

## Vocabularies

The `lib/aca_entities/libraries/` folder defines a `core_libary` and other namespaced libraries designed to load required artifacts and dependencies rather than the entire library. For example, `lib/aca_entities/libraries/fdsh_library.rb` loads only the FDSH namespace and dependencies necessary to support communication with CMS services.

### Account Transfer Protocol

Vocabularies and transforms that enable account and eligibility information exchange between FFE Account Transfer Protocol (ATP) and IdeaCrew's CV.

### AsynApi

Shared configuration files that enable publication/subscribe (pub/sub) service producers and consumers to exchange messages between mircoservices. Files are organized by microservice and communication protocol.

These yaml-formatted definitions use the [AsyncAPI 2.0](https://www.asyncapi.com/docs/specifications/v2.0.0) specification to describe API endpoints in a protocol-neutral form. Tools like IdeaCrew's [EventSource gem](https://github.com/ideacrew/aca_entities.git) use these definitions to instantiate connections and channels between described services. Other tools may use them to create self-documenting API endpoints.

### CRMs

Integration with Customer Relationship Management (CRM) systems including SugarCRM.

### FDSH

Integration with CMS's Federal Data Sharing Hub (FDSH) that supports eligibility determination and verification services necessary to operate a State-based Exchange (SBE).

### Google

Integrations with Google Map services including interactive UI maps and address geocoding services.

### Ledger

Integrations with accounting services including Quickbooks Online.

### MagiMedicaid

Integrations and code that enable Affordable Care Act (ACA) financial assistance eligibility determinations, including MAGI Medicaid, Advance Premium Tax Credit (APTC) and Cost Sharing Reductions (CSRs)

## Contributing

AcaEnties vocabularies are based on [dry-rb](https://dry-rb.org/) libraries and support Domain-driven development. IdeaCrew conventions use Entity classes to define attributes and domain logic. Do not include data coercions or transformations in Entities. Rather, use Contracts and Operations to filter and shape data prior to instantiating Entity structs.

Do include `yardoc` API documentation and Rspec specs for all Entities, Contracts, Operations and other content added to AcaEntities.

### Extending AcaEntities Domain Model

Before adding new code to AcaEntties, review existing vocabularies to use or extend to support requirements. Start with the `lib/aca_entities/libraries/` folder. Next, search `lib/aca_entities` subfolders for suitable models. Note that some subfolders define vocabularies that aren't obvious from the folder name.

Projects that create new must use the `lib/aca_entities/libraries` and namespacing conventions to tie in the new vocaulary in a modular way. Projects that update existing vocabularies should include refactoring to do the same.

### Issues

#### Known Issues

Some subject-specific vocabularies are unnecessarily loaded: 1) via `lib/aca_entities/libraries/core_library.rb`, or 2) via `lib/aca_entities.rb`. These should be refactored to use the `lib/aca_entities/libraries` convention to isolate the vocaulary and its dependencies to enable modular loading.

#### Other Issues

Bug reports and pull requests are welcome on GitHub at [aca_entities](https://github.com/ideacrew/aca_entities). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ideacrew/aca_entities/blob/trunk/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AcaEntities project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ideacrew/aca_entities/blob/master/CODE_OF_CONDUCT.md).
