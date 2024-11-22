# typed: strict
# frozen_string_literal: true

module RubyIndexer
  module EntryManager
    extend T::Sig

    sig { params(entry: Entry, skip_prefix_tree: T::Boolean).void }
    def add(entry, skip_prefix_tree: false)
      name = entry.name
      (@entries[name] ||= []) << entry
      (@files_to_entries[entry.file_path] ||= []) << entry
      @entries_tree.insert(name, T.must(@entries[name])) unless skip_prefix_tree
    end

    sig { params(indexable: IndexablePath).void }
    def delete(indexable)
      # ...existing code...
    end

    sig { params(fully_qualified_name: String).returns(T.nilable(T::Array[Entry])) }
    def [](fully_qualified_name)
      @entries[fully_qualified_name.delete_prefix("::")]
    end

    sig { params(query: String).returns(T::Array[IndexablePath]) }
    def search_require_paths(query)
      @require_paths_tree.search(query)
    end

    sig { params(query: T.nilable(String)).returns(T::Array[Entry]) }
    def fuzzy_search(query)
      # ...existing code...
    end

    sig { returns(T::Boolean) }
    def empty?
      @entries.empty?
    end

    sig { returns(T::Array[String]) }
    def names
      @entries.keys
    end

    sig { params(name: String).returns(T::Boolean) }
    def indexed?(name)
      @entries.key?(name)
    end

    sig { returns(Integer) }
    def length
      @entries.count
    end
  end
end
