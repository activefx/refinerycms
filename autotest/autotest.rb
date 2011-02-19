###  uncomment any of the following requires applicable for your system
###  and then copy this to .autotest if you are using the ZenTest autotest.
# require "autotest/restart"
# require "test_notifier/runner/autotest"
# require "redgreen/autotest"
# require "autotest/timestamp"

#require 'redgreen'
#require 'autotest/timestamp'
#require 'autotest/bundler'

#module Autotest::GnomeNotify
#  def self.notify title, msg, img
#    system "notify-send '#{title}' '#{msg}' -i #{img} -t 2000"
#  end

#  Autotest.add_hook :ran_command do |at|
#    image_root = "~/.autotest_images"
#    results = [at.results].flatten.join("\n")
#    results.gsub!(/\\e\[\d+m/,'')
#    output = results.slice(/(\d+)\sexamples?,\s(\d+)\sfailures?(,\s(\d+)\spending?|)/)
#    full_sentence, green, failures, garbage, pending = $~.to_a.map(&:to_i)
#    if output
#      if failures > 0
#        notify "FAIL", "#{output}", "#{image_root}/fail.png"
#      elsif pending > 0
#        notify "Pending", "#{output}", "#{image_root}/pending.png"
#      else
#        notify "Pass", "#{output}", "#{image_root}/pass.png"
#      end
#    end
#  end
#end

# adds exceptions from .gitignore file, please modify exceptions there!
imported_exceptions =  IO.readlines('.gitignore').inject([]) do |acc, line|
  acc << line.strip if line.to_s[0] != '#' && line.strip != ''; acc
end

Autotest.add_hook :initialize do |autotest|
  imported_exceptions.each do |exception|
    autotest.add_exception(exception)
  end
end

