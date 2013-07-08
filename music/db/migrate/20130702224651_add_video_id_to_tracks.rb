class AddVideoIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :video_id, :string
  end
end
