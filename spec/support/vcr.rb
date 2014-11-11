require 'vcr'
require 'rspec'

ACCESS_TOKEN = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
FORM_ID = 0000000
INACCESSIBLE_FORM_ID = 0000001

VCR.configure do |c|
    c.cassette_library_dir = 'spec/vcr'
    c.hook_into :webmock # or :fakeweb
    c.filter_sensitive_data('<ACCESS_TOKEN>') { ACCESS_TOKEN }
    c.filter_sensitive_data('<FORM_ID>') { FORM_ID }
    c.filter_sensitive_data('<INACCESSIBLE_FORM_ID>') { INACCESSIBLE_FORM_ID }
    c.default_cassette_options = { record: :new_episodes }
    c.configure_rspec_metadata!
end
