class ActsAsVerifiableMigrationGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.migration_template 'acts_as_verifiable_migration.rb', 'db/migrate'
    end
  end

  def file_name
    'acts_as_verifiable_migration'
  end
end
