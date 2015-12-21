# == Schema Information
#
# Table name: tracks
#
#  id          :integer          not null, primary key
#  user_id     :integer          not null
#  title       :string           not null
#  track_url   :string           not null
#  img_url     :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

class Track < ActiveRecord::Base
  extend FriendlyId

  after_initialize :ensure_track_data

  before_save :parameterize_slug

  friendly_id :title, use: :slugged

  validates :title, uniqueness: { scope: :user_id }

  validates :slug, uniqueness: { scope: :user_id }

  validates :track_url,
    presence: true,
    uniqueness: true

  validates_presence_of :user_id

  belongs_to :user
  has_many :playlistings, dependent: :destroy
  has_many :playlists, through: :playlistings

  private

  def ensure_track_data
    self.title = "Untitled" if self.title.nil?
    self.img_url = "/assets/corgi.jpg" if self.img_url.nil?
    self.description = "No description" if self.description.nil?
  end

  def ensure_slug
    self.slug = self.title.parameterize
  end
end
