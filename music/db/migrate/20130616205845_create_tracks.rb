class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :youtube_url
      t.timestamps
    end
  end
end
