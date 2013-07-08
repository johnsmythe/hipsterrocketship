module TracksHelper

require "addressable/uri"
require 'youtube_it'

	def getTrackInfo(youtube_url)
			puts "hello"
			songInfo = Hash.new

			client = YouTubeIt::Client.new(:dev_key => "AI39si7i0z9sv-1AtHL7eCTYksp82e713nPlu9pNk5f1X73--hBSW4B5v3eiIpvC095Rop2bcq5XdVQRXOpHpA631Hyxz26dgA")
			begin
				video_obj = client.video_by(youtube_url)
			rescue OpenURI::HTTPError
				puts "ignoring error"
				#ignoring a 400 error
				#video_obj ={}
			end
			
		#	puts "video_obj #{video_obj}"
			if video_obj
				songInfo[:title] = video_obj.title
				songInfo[:thumbnail] = video_obj.thumbnails[2].url
				temp = video_obj.video_id.split(",")
				temp = video_obj.video_id.split(":")
				songInfo[:video_id] = temp[3]
			end
			return songInfo
	end


	def youTubeQuery(searchParam) 
			songInfo = Hash.new
			client = YouTubeIt::Client.new(:dev_key => "AI39si7i0z9sv-1AtHL7eCTYksp82e713nPlu9pNk5f1X73--hBSW4B5v3eiIpvC095Rop2bcq5XdVQRXOpHpA631Hyxz26dgA")
			searchResults = client.videos_by(:query => searchParam, :hd => "true")
			
			bestResult = searchResults.videos.first
			puts "result: #{bestResult}"			
			if bestResult
				songInfo[:video_id] = bestResult.video_id.split(",")[1].split(":")[2]
				songInfo[:title] = bestResult.title
				songInfo[:thumbnail] = bestResult.thumbnails[2].url
			end
			return songInfo
	end

	def validate_link(link)
		@video_id = nil
		@uri = Addressable::URI.parse(link)
		#puts "query: #{@uri.query_values["v"]}"
		#puts "path: #{@uri.path}"
		#puts "host: #{@uri.host}"
		if @uri.host == 'www.youtube.com' || @uri.host == 'youtu.be'
			if @uri.path == "/watch"
				if @uri.query_values["v"]
					return @video_id = @uri.query_values["v"] 
				end
				
			else
				if @uri.path[1..-1].length() > 0
					return @video_id = @uri.path[1..-1]
				end
			end
		end
		return nil
	end

	def is_url(link)
		@uri = Addressable::URI.parse(link)
		if @uri.host == 'www.youtube.com' || @uri.host == 'youtu.be'
			return true
		end
		return false
	end	
end
