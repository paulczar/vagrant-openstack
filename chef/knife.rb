log_level                :info
log_location             STDOUT
node_name                'admin'
client_key               '/home/vagrant/.chef/admin.pem'
validation_client_name   'chef-validator'
validation_key           '.chef/chef-validator.pem'
chef_server_url          'https://chef'
cache_type               'BasicFile'
cache_options( :path => '/home/vagrant/.chef/checksums' )
