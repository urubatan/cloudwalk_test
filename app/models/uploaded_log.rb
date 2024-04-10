class UploadedLog < ApplicationRecord
  has_one_attached :logfile
  has_many :games, dependent: :destroy
  has_many :player_rankings, dependent: :destroy

  after_create_commit -> { ProcessUploadedLogJob.perform_later(self) }
end
