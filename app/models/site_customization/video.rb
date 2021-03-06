class SiteCustomization::Video < ActiveRecord::Base
  has_attached_file :video

  validates :name, presence: true, uniqueness: true
  validates_attachment_content_type :video, content_type: ["application/mp4", "audio/mp4", "video/mp4", "video/vnd.objectvideo"]

  def self.one_video
    find_by(name: "welcome_video") || create!(name: "welcome_video")
  end

  def self.video_path_for(filename)
    video_name = filename.split(".").first

    videable = find_by(name: video_name)
    videable.present? && videable.video.exists? ? videable.video.url : nil
  end
end
