# frozen_string_literal: true

require_relative "lib/rails/kompot/version"

Gem::Specification.new do |spec|
  spec.name = "rails-kompot"
  spec.version = Rails::Kompot::VERSION
  spec.authors = ["Anatolii Kryvishyn"]
  spec.email = ["9845250+anatoliikryvishyn@users.noreply.github.com"]

  spec.summary = "Opinionated Rails API generator with pre-configured gems and Claude Code skills."
  spec.description = "A CLI wrapper around `rails new` that applies preset flags (-d postgresql -T --api --minimal), " \
                     "adds a curated set of gems (RSpec, RuboCop, factory_bot, Bullet, SimpleCov, test-prof), " \
                     "and bootstraps Claude Code slash commands for common development tasks " \
                     "(fix, lint, commit, review-pr, add-tests, code-coverage, docs, deliver)."
  spec.homepage = "https://github.com/kompoteria/rails-kompot"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kompoteria/rails-kompot"
  spec.metadata["changelog_uri"] = "https://github.com/kompoteria/rails-kompot/blob/main/CHANGELOG.md"
  spec.metadata["bug_tracker_uri"] = "https://github.com/kompoteria/rails-kompot/issues"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 7.0", "< 9"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
