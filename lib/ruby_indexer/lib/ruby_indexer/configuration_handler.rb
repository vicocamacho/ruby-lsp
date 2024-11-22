# typed: strict
# frozen_string_literal: true

module RubyIndexer
  module ConfigurationHandler
    extend T::Sig

    sig { returns(Configuration) }
    attr_reader :configuration

    sig { void }
    def initialize_configuration
      @configuration = T.let(RubyIndexer::Configuration.new, Configuration)
    end
  end
end
