#!/Users/MacbookPro/.rbenv/versions/2.0.0-p247/bin/ruby

if ARGV[0] =~ /^(--?edit|-e)$/i
  system("vim -O '#{__FILE__}' '#{File.dirname(File.realpath(__FILE__))}/lib/gooddrama.rb'")
else
  require "#{File.dirname(File.realpath(__FILE__))}/lib/gooddrama"

  wgets = []
  GoodDrama.new(ARGV[0], part: 1, mirror: ARGV[1] || 1).files.uniq{|f|
    File.basename(f).gsub(/[?&].*/,'')
  }.each do |file|
    next if file.strip.length == 0
    wgets.push "download '#{file}'"
    # `open '#{file}'` unless !!ARGV[2]
  end

  puts wgets
  printf "\nAuto-download? (y|n) [y]: "
  yn = $stdin.gets
  yn.chomp!
  if yn.length == 0 || yn =~ /y/i
    puts
    puts wgets.map{|cmd| `#{cmd}` }
  end
end

