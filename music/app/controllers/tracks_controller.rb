class TracksController < ApplicationController

include TracksHelper

def index
	@track = Track.new
	@tracks = Track.all
	
	#
	
end

def create
	
	#checking to see if link or search params
	if is_url(params[:track][:youtube_url])	
		puts "is valid url"
		#use api to populate title and thumbnail
		@trackinfo = getTrackInfo(params[:track][:youtube_url])
	else
		#must be a search param

		puts "searching for: #{params[:track][:youtube_url]}"
		@trackinfo = youTubeQuery(params[:track][:youtube_url])

	end

	

	#puts "title: #{@trackinfo[:title]}"
	#puts "id: #{@trackinfo[:video_id]}"
	#puts "thumbnail: #{@trackinfo[:thumbnail]}"
	
	params[:track][:title] = @trackinfo[:title]
	params[:track][:thumbnail_url] = @trackinfo[:thumbnail]
	params[:track][:video_id] = @trackinfo[:video_id]
	@track = Track.new(params[:track])

	@tracks = Track.all
	@video_ids = Track.pluck(:video_id)
	#puts "curent list of tracks"
	#@tracks.each do |track|
	#	puts "track: #{track}"
	#end
	#puts "list of v_id: #{@video_ids}"

	if @track.save

	else 
		render :action=>"index"
	end
end

def destroy
	@track = Track.find(params[:id])
	@track.destroy
end

def show
	@tracklist = Track.pluck(:video_id)
end

end

