#--
# Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
#
# Copyright (c) 2009-2012 Simone Carletti <weppos@weppos.net>
#++


module TabsOnRails

  # Holds information about library version.
  module Version
    MAJOR = 2
    MINOR = 1
    PATCH = 1
    BUILD = nil

    STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join(".")
  end

  # The current library version.
  VERSION = Version::STRING

end
