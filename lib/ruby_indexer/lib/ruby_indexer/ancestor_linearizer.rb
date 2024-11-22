# typed: strict
# frozen_string_literal: true

module RubyIndexer
  module AncestorLinearizer
    extend T::Sig

    sig { params(fully_qualified_name: String).returns(T::Array[String]) }
    def linearized_ancestors_of(fully_qualified_name)
      # ...existing code...
    end

    sig do
      params(ancestors: T::Array[String], namespace_entries: T::Array[Entry::Namespace], nesting: T::Array[String]).void
    end
    def linearize_mixins(ancestors, namespace_entries, nesting)
      # ...existing code...
    end

    sig do
      params(
        ancestors: T::Array[String],
        attached_class_name: String,
        fully_qualified_name: String,
        namespace_entries: T::Array[Entry::Namespace],
        nesting: T::Array[String],
        singleton_levels: Integer,
      ).void
    end
    def linearize_superclass(ancestors, attached_class_name, fully_qualified_name, namespace_entries, nesting,
      singleton_levels)
      # ...existing code...
    end
  end
end
