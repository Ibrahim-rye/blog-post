## Rails 6.1.7.10 (October 23, 2024) ##

*   No changes.


## Rails 6.1.7.9 (October 15, 2024) ##

*   No changes.


## Rails 6.1.7.8 (June 04, 2024) ##

*   No changes.


## Rails 6.1.7.7 (February 21, 2024) ##

*   No changes.


## Rails 6.1.7.6 (August 22, 2023) ##

*   No changes.


## Rails 6.1.7.5 (August 22, 2023) ##

*   No changes.


## Rails 6.1.7.4 (June 26, 2023) ##

*   No changes.


## Rails 6.1.7.3 (March 13, 2023) ##

*   No changes.


## Rails 6.1.7.2 (January 24, 2023) ##

*   No changes.


## Rails 6.1.7.1 (January 17, 2023) ##

*   No changes.


## Rails 6.1.7 (September 09, 2022) ##

*   No changes.


## Rails 6.1.6.1 (July 12, 2022) ##

*   No changes.


## Rails 6.1.6 (May 09, 2022) ##

*   No changes.


## Rails 6.1.5.1 (April 26, 2022) ##

*   No changes.


## Rails 6.1.5 (March 09, 2022) ##

*   Clear secure password cache if password is set to `nil`

    Before:

       user.password = 'something'
       user.password = nil

       user.password # => 'something'

    Now:

       user.password = 'something'
       user.password = nil

       user.password # => nil

    *Markus Doits*

*   Fix delegation in `ActiveModel::Type::Registry#lookup` and `ActiveModel::Type.lookup`

    Passing a last positional argument `{}` would be incorrectly considered as keyword argument.

    *Benoit Daloze*

*   Fix `to_json` after `changes_applied` for `ActiveModel::Dirty` object.

    *Ryuta Kamizono*


## Rails 6.1.4.7 (March 08, 2022) ##

*   No changes.


## Rails 6.1.4.6 (February 11, 2022) ##

*   No changes.


## Rails 6.1.4.5 (February 11, 2022) ##

*   No changes.


## Rails 6.1.4.4 (December 15, 2021) ##

*   No changes.


## Rails 6.1.4.3 (December 14, 2021) ##

*   No changes.


## Rails 6.1.4.2 (December 14, 2021) ##

*   No changes.


## Rails 6.1.4.1 (August 19, 2021) ##

*   No changes.


## Rails 6.1.4 (June 24, 2021) ##

*   Fix `to_json` for `ActiveModel::Dirty` object.

    Exclude +mutations_from_database+ attribute from json as it lead to recursion.

    *Anil Maurya*


## Rails 6.1.3.2 (May 05, 2021) ##

*   No changes.


## Rails 6.1.3.1 (March 26, 2021) ##

*   No changes.


## Rails 6.1.3 (February 17, 2021) ##

*   No changes.


## Rails 6.1.2.1 (February 10, 2021) ##

*   No changes.


## Rails 6.1.2 (February 09, 2021) ##

*   No changes.


## Rails 6.1.1 (January 07, 2021) ##

*   No changes.


## Rails 6.1.0 (December 09, 2020) ##

*   Pass in `base` instead of `base_class` to Error.human_attribute_name

    This is useful in cases where the `human_attribute_name` method depends
    on other attributes' values of the class under validation to derive what the
    attribute name should be.

    *Filipe Sabella*

*   Deprecate marshalling load from legacy attributes format.

    *Ryuta Kamizono*

*   `*_previously_changed?` accepts `:from` and `:to` keyword arguments like `*_changed?`.

        topic.update!(status: :archived)
        topic.status_previously_changed?(from: "active", to: "archived")
        # => true

    *George Claghorn*

*   Raise FrozenError when trying to write attributes that aren't backed by the database on an object that is frozen:

        class Animal
          include ActiveModel::Attributes
          attribute :age
        end

        animal = Animal.new
        animal.freeze
        animal.age = 25 # => FrozenError, "can't modify a frozen Animal"

    *Josh Brody*

*   Add `*_previously_was` attribute methods when dirty tracking. Example:

        pirate.update(catchphrase: "Ahoy!")
        pirate.previous_changes["catchphrase"] # => ["Thar She Blows!", "Ahoy!"]
        pirate.catchphrase_previously_was # => "Thar She Blows!"

    *DHH*

*   Encapsulate each validation error as an Error object.

    The `ActiveModel`’s `errors` collection is now an array of these Error
    objects, instead of messages/details hash.

    For each of these `Error` object, its `message` and `full_message` methods
    are for generating error messages. Its `details` method would return error’s
    extra parameters, found in the original `details` hash.

    The change tries its best at maintaining backward compatibility, however
    some edge cases won’t be covered, like `errors#first` will return `ActiveModel::Error` and manipulating
    `errors.messages` and `errors.details` hashes directly will have no effect. Moving forward,
    please convert those direct manipulations to use provided API methods instead.
    Please note that `errors#add` now accepts `options` as keyword arguments instead of `Hash` which
    introduced a change in Ruby 3 to [keyword arguments][kwargs-ann].

    [kwargs-ann]: https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/

    The list of deprecated methods and their planned future behavioral changes at the next major release are:

    * `errors#slice!` will be removed.
    * `errors#each` with the `key, value` two-arguments block will stop working, while the `error` single-argument block would return `Error` object.
    * `errors#values` will be removed.
    * `errors#keys` will be removed.
    * `errors#to_xml` will be removed.
    * `errors#to_h` will be removed, and can be replaced with `errors#to_hash`.
    * Manipulating `errors` itself as a hash will have no effect (e.g. `errors[:foo] = 'bar'`).
    * Manipulating the hash returned by `errors#messages` (e.g. `errors.messages[:foo] = 'bar'`) will have no effect.
    * Manipulating the hash returned by `errors#details` (e.g. `errors.details[:foo].clear`) will have no effect.

    *lulalala*


Please check [6-0-stable](https://github.com/rails/rails/blob/6-0-stable/activemodel/CHANGELOG.md) for previous changes.
