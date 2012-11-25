
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linked_in, 'jUzrjfxj4j6u8i', 'OFHzBKYQxSNW66wy' , :scope => 'r_basicprofile r_fullprofile r_emailaddress r_contactinfo'
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end
