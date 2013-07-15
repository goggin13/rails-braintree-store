
braintree_config = YAML.load_file(Rails.root.join('config', 'braintree.yml'))
BRAINTREE = braintree_config[Rails.env]

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = BRAINTREE['merchant_id']
Braintree::Configuration.public_key = BRAINTREE['public_key']
Braintree::Configuration.private_key = BRAINTREE['private_key']
