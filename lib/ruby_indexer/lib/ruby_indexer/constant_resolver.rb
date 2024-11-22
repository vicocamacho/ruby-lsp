# typed: strict
# frozen_string_literal: true

module RubyIndexer
  module ConstantResolver
    extend T::Sig

    sig do
      params(
        name: String,
        nesting: T::Array[String],
        seen_names: T::Array[String],
      ).returns(T.nilable(T::Array[T.any(
        Entry::Namespace,
        Entry::ConstantAlias,
        Entry::UnresolvedConstantAlias,
      )]))
    end
    def resolve(name, nesting, seen_names = [])
      # ...existing code...
    end

    sig do
      params(
        entry: Entry::UnresolvedConstantAlias,
        seen_names: T::Array[String],
      ).returns(T.any(Entry::ConstantAlias, Entry::UnresolvedConstantAlias))
    end
    def resolve_alias(entry, seen_names)
      # ...existing code...
    end

    sig do
      params(
        name: String,
        nesting: T::Array[String],
        seen_names: T::Array[String],
      ).returns(T.nilable(T::Array[T.any(
        Entry::Namespace,
        Entry::ConstantAlias,
        Entry::UnresolvedConstantAlias,
      )]))
    end
    def lookup_enclosing_scopes(name, nesting, seen_names)
      # ...existing code...
    end

    sig do
      params(
        name: String,
        nesting: T::Array[String],
        seen_names: T::Array[String],
      ).returns(T.nilable(T::Array[T.any(
        Entry::Namespace,
        Entry::ConstantAlias,
        Entry::UnresolvedConstantAlias,
      )]))
    end
    def lookup_ancestor_chain(name, nesting, seen_names)
      # ...existing code...
    end

    sig do
      params(
        full_name: String,
        seen_names: T::Array[String],
      ).returns(
        T.nilable(T::Array[T.any(
          Entry::Namespace,
          Entry::ConstantAlias,
          Entry::UnresolvedConstantAlias,
        )]),
      )
    end
    def direct_or_aliased_constant(full_name, seen_names)
      # ...existing code...
    end
  end
end
