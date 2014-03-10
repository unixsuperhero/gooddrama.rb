#!/Users/MacbookPro/.rbenv/versions/2.0.0-p247/bin/ruby

if ARGV[0] =~ /^(--?edit|-e)$/i
  system("vim -O '#{__FILE__}' '#{File.dirname(File.realpath(__FILE__))}/lib/drama.rb'")
else
  require "#{File.dirname(File.realpath(__FILE__))}/lib/drama"

  episode_name = ARGV[0][/[^\/]*episode[^\/]*/i]
  wgets = []
  Drama.new(ARGV[0]).media.each do |file|
    extension = file[/[.](?:avi|mp4|flv|mpe?g|srt)/i]
    wgets.push "wget -cb '#{file.gsub(/\+/, ' ')}' -O '#{episode_name}#{extension}'"
  end

  puts wgets
end

