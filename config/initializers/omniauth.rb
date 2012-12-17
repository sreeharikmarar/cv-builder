
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linked_in, 'jUzrjfxj4j6u8i', 'OFHzBKYQxSNW66wy' , :scope => 'r_basicprofile r_fullprofile r_emailaddress r_contactinfo'
#  require 'github_api'
  provider :github, 'c3c55176248542521759', 'e5673dbb73c7e010781e8c1457d20a796ad9c19d' , :scope => 'repo'
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
