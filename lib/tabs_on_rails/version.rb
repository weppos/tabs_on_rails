# 
# = Tabs on Rails
#
# Simple Rails plugin for creating and managing Tabs.
# 
#
# Category::    Rails
# Package::     TabsOnRails
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
# SVN: $Id$
#++


module TabsOnRails

  module Version
    MAJOR = 0
    MINOR = 1
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  VERSION         = Version::STRING
  STATUS          = 'development'
  BUILD           = '$Id$'.match(/(\d+)/).to_a.first

end
