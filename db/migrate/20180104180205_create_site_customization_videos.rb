class CreateSiteCustomizationVideos < ActiveRecord::Migration
  def change
    create_table :site_customization_videos do |t|
      t.string :name, null: false
      t.attachment :video
      t.timestamps null: false
    end

    add_index :site_customization_videos, :name, unique: true
  end
end
