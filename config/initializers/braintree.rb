
braintree_config = YAML.load_file(Rails.root.join('config', 'braintree.yml'))
BRAINTREE = braintree_config[Rails.env]
