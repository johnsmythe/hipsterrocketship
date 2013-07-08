class Track < ActiveRecord::Base
  attr_accessible :title, :youtube_url, :thumbnail_url, :video_id
  validates :title, :thumbnail_url, :video_id, :presence => {:message => 'my tits smells like biscuits'}
  #before_create :populate_title_link
#  def linkInput    #Input is youtube link as opposed to artist name/song title
#	trackInfo = getTrackInfo(@youtube_url) #Syntax correct??
#	@title = trackInfo["title"]
#	@thumbnail_url = trackInfo["thumbnail"]
#  end

end
