# typed: strict
# frozen_string_literal: true

module RubyIndexer
  module MethodResolver
    extend T::Sig

    sig do
      params(
        method_name: String,
        receiver_name: String,
        seen_names: T::Array[String],
        inherited_only: T::Boolean,
      ).returns(T.nilable(T::Array[T.any(Entry::Member, Entry::MethodAlias)]))
    end
    def resolve_method(method_name, receiver_name, seen_names = [], inherited_only: false)
      method_entries = self[method_name]
      return unless method_entries

      ancestors = linearized_ancestors_of(receiver_name.delete_prefix("::"))
      ancestors.each do |ancestor|
        next if inherited_only && ancestor == receiver_name

        found = method_entries.filter_map do |entry|
          case entry
          when Entry::Member, Entry::MethodAlias
            entry if entry.owner&.name == ancestor
          when Entry::UnresolvedMethodAlias
            # Resolve aliases lazily as we find them
            if entry.owner&.name == ancestor
              resolved_alias = resolve_method_alias(entry, receiver_name, seen_names)
              resolved_alias if resolved_alias.is_a?(Entry::MethodAlias)
            end
          end
        end

        return found if found.any?
      end

      nil
    rescue NonExistingNamespaceError
      nil
    end

    # Attempt to resolve a given unresolved method alias. This method returns the resolved alias if we managed to
    # identify the target or the same unresolved alias entry if we couldn't
    sig do
      params(
        entry: Entry::UnresolvedMethodAlias,
        receiver_name: String,
        seen_names: T::Array[String],
      ).returns(T.any(Entry::MethodAlias, Entry::UnresolvedMethodAlias))
    end
    def resolve_method_alias(entry, receiver_name, seen_names)
      new_name = entry.new_name
      return entry if new_name == entry.old_name
      return entry if seen_names.include?(new_name)

      seen_names << new_name

      target_method_entries = resolve_method(entry.old_name, receiver_name, seen_names)
      return entry unless target_method_entries

      resolved_alias = Entry::MethodAlias.new(T.must(target_method_entries.first), entry)
      original_entries = T.must(@entries[new_name])
      original_entries.delete(entry)
      original_entries << resolved_alias
      resolved_alias
    end
  end
end
