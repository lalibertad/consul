class SiteCustomization::Video < ActiveRecord::Base
  has_attached_file :video

  validates :name, presence: true, uniqueness: true
  validates_attachment_content_type :video, content_type: ['application/x-shockwave-flash', 'application/x-shockwave-flash', 'application/flv', 'video/x-flv']

  def self.one_video
    find_by(name: "welcome_video") || create!(name: "welcome_video")
  end
end
