require 'uri'
require 'net/http'
require 'pp'

class GoodDrama
  attr_accessor :uri, :parts, :embeds, :files
  attr_accessor :response, :body, :part, :mirror

  def initialize(uri, opts={})
    @uri = URI(uri)
    @part = opts.fetch(:part, 1).to_i
    @mirror = opts.fetch(:mirror, 1).to_i
    @embeds = []
    @files = []
  end

  def response
    @response ||= Net::HTTP.get_response(uri)
  end

  def body
    #@body = IO.read('test.html')
    @body ||= response.body
  end

  def parts_regex
    /href=['"]([^"']*\/#{mirror}-(\d\d*))["'][^>]*>part\s*/i
  end

  def parts
    @parts ||= [[uri,'1']] + body.scan(parts_regex)
  end

  def videos_regex
    /https?:..[^'"><]*(?:[.](?:mp4|flv|mpe?g|avi)|embed)[^'"><]*/i
  end

  def videos
    @videos ||= body.scan(videos_regex).map(&URI.method(:decode))
  end

  def embed_regex
    /https?:..[^'"]*embed.php[^'"]*/i
  end

  def embed
    @embed ||= body.scan(file_regex).grep(/mp4|flv/i).first(mirror).last
  end

  def file_regex
    /https?:..[^'"]*(?:part|clip).?#{part}[^'"]*/i
  end

  def file
    return '' if embed == nil
    uri = URI(embed)
    r = Net::HTTP.get_response(uri)
    URI.decode r.body.scan(file_regex).first.to_s
  end

  def embeds
    parts.map do |url,part|
      (url == @url) ? embed : GoodDrama.new(url,part: part,mirror: mirror).embed
    end
  end

  def files
    parts.map do |url,part|
      (url == @url) ? file : GoodDrama.new(url,part: part,mirror: mirror).file
    end
  end
end

