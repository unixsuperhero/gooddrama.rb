#!/Users/MacbookPro/.rbenv/versions/2.0.0-p247/bin/ruby

if ARGV[0] =~ /^(--?edit|-e)$/i
  system("vim -O '#{__FILE__}' '#{File.dirname(File.realpath(__FILE__))}/lib/gooddrama.rb'")
else
  require "#{File.dirname(File.realpath(__FILE__))}/lib/gooddrama"

  episode_name = ARGV[0][/[^\/]*episode[^\/]*/i]
  wgets = []
  GoodDrama.new(ARGV[0], part: 1, mirror: ARGV[1] || 1).videos.each do |file|
    videos = GoodDrama.new(file).videos
    if videos.count > 0
      videos.each do |video_file|
        extension = video_file[/[.](?:avi|mp4|flv|mpe?g)/i]
        wgets.push "wget -cb '#{video_file}' -O '#{episode_name}#{extension}'"
        # `open '#{video_file}'` unless !!ARGV[2]
      end
    else
      extension = video_file[/[.](?:avi|mp4|flv|mpe?g)/i]
      wgets.push "wget -cb '#{file}' -O '#{episode_name}#{extension}'"
    end
  end

  puts wgets
end

