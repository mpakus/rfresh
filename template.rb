require "bundler"

# def source_paths
#   # if __FILE__ =~ %r{\Ahttps?://}
#   ['https://raw.githubusercontent.com/mpakus/rfresh/main/files/']
#   # else
#   #   [File.join(File.dirname(__FILE__), 'files/')]
#   # end
#   # RAILS_TEMPLATE_PATH = File.dirname(rails_template)
#   # [RAILS_TEMPLATE_PATH]
#   # [File.join(File.dirname(__FILE__), 'files/')]
# end

# def add_template_repository_to_source_path
#   if __FILE__ =~ %r{\Ahttps?://}
#     git_repo = 'https://raw.githubusercontent.com/mpakus/rfresh/main/files/'
#
#     require "tmpdir"
#     source_paths.unshift(tempdir = Dir.mktmpdir("rfresh-"))
#     at_exit { FileUtils.remove_entry(tempdir) }
#     git clone: [
#                  "--quiet",
#                  git_repo,
#                  tempdir
#                ].map(&:shellescape).join(" ")
#
#     if (branch = __FILE__[%r{https://raw.githubusercontent.com/mpakus/rfresh/(.+)/template.rb}, 1])
#       Dir.chdir(tempdir) { git checkout: branch }
#     end
#   else
#     source_paths.unshift(File.dirname(__FILE__))
#   end
# end

# def add_template_repository_to_source_path
#   if __FILE__ =~ %r{\Ahttps?://}
#     require "tmpdir"
#     source_paths.unshift(tempdir = Dir.mktmpdir("rfresh-"))
#     at_exit { FileUtils.remove_entry(tempdir) }
#     git clone: [
#                  "--quiet",
#                  "https://github.com/mpakus/rfresh.git",
#                  tempdir
#                ].map(&:shellescape).join(" ")
#
#     if (branch = __FILE__[%r{rfresh/(.+)/template.rb}, 1])
#       Dir.chdir(tempdir) { git checkout: branch }
#     end
#   else
#     source_paths.unshift(File.dirname(__FILE__))
#   end
# end

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("rfresh-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
                 "--quiet",
                 "https://github.com/mpakus/rfresh.git",
                 tempdir
               ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{rfresh/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def apply_template!
  add_template_repository_to_source_path

  gem 'slim-rails'

  gem_group :test do
    gem 'rspec-rails'
    gem 'factory_bot_rails'
    gem 'faker'
    gem 'fuubar'
    gem 'shoulda-matchers'
    gem 'simplecov'
  end

  gem_group :development, :test do
    gem 'awesome_print'
  end

  gem_group :development do
    gem 'annotate'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'brakeman'
    gem 'bundle-audit'
    gem 'foreman'
    gem 'letter_opener'
    gem 'ordinare', require: false
    gem 'rack-mini-profiler', '~> 2.0'
    gem 'rubocop', require: false
    gem 'rubocop-performance', require: false
    gem 'rubocop-rails', require: false
    gem 'rubocop-rspec', require: false
  end

  environment 'Slim::Engine.set_options pretty: true, sort_attrs: false',
              env: 'development'

  copy_file '.rubocop.yml'
  copy_file 'Procfile.dev'
  copy_file 'auto_annotate_models.rake', 'lib/tasks/auto_annotate_models.rake'
  copy_file 'workflow.yml', '.github/workflows/workflow.yml'

  after_bundle do
    generate 'rspec:install'
    copy_file 'rails_helper.rb', 'spec/rails_helper.rb', force: true
    copy_file '.rspec', force: true
  end
end

apply_template!


