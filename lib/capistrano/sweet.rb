require "capistrano/sweet/version"

cap_version = Gem::Specification.find_by_name('capistrano').version
if cap_version >= Gem::Version.new('3.0.0')
  #
  # Load Tasks from sweet "cap" file
  #
  load File.expand_path('../../tasks/custom_links.rb', __FILE__)
  load File.expand_path('../../tasks/synch_vendor_cache.rb', __FILE__)
else
  raise Gem::LoadError, "Capistrano-Sweet requires capistrano version 3.0.0 or greater, version detected: #{cap_version}"
end

module Capistrano
  module Sweet
    # Your code goes here...
  end
end
