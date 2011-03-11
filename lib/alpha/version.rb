require 'pathname'
gempath = Pathname.new(File.expand_path('../../../', __FILE__))
require gempath.join('base', 'lib', 'base', 'refinery')

module Alpha
  VERSION = ::Refinery.version
end

