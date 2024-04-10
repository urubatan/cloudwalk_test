class UploadedLog < ApplicationRecord
  has_one_attached :logfile
  has_many :games
  has_many :player_rankings
end
