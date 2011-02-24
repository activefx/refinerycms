%w(base core settings authentication dashboard images pages resources).each do |engine|
  #begin
  #  require "refinerycms-#{engine}"
  #rescue
    require File.expand_path("../../#{engine}/lib/refinerycms-#{engine}", __FILE__)
  #end
end

