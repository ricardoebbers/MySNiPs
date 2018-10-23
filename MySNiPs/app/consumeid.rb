require_relative "./gluttony/consume"

devourer = Gluttony::Consume.new
if ARGV.empty?
  puts "Pass file name (without extension)"
else
  devourer.read_list ARGV[0]
end
