
config = YAML.safe_load File.read(File.join(Rails.root, 'config', 'widgets.yml'))

Rails.application.config.widgets = config
