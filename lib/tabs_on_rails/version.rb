# 
# = Tabs on Rails
#
# A simple Ruby on Rails plugin for creating and managing Tabs.
# 
#
# Category::    Rails
# Package::     TabsOnRails
# Author::      Simone Carletti <weppos@weppos.net>
# License::     MIT License
#
#--
#
#++


module TabsOnRails

  module Version
    MAJOR = 0
    MINOR = 8
    TINY  = 0

    STRING = [MAJOR, MINOR, TINY].join('.')
  end

  VERSION         = Version::STRING
  STATUS          = 'beta'
  BUILD           = ''.match(/(\d+)/).to_a.first

end
