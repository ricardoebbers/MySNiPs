require_relative "./gluttony/consume"
require "fileutils"

devourer = Gluttony::Consume.new
# devourer.make_list
FileUtils.mkdir_p "idlists"
devourer.split_list ARGV[0].to_i unless ARGV.empty?
