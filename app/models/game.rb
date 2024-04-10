class Game < ApplicationRecord
  belongs_to :uploaded_log
  has_many :kill_by_means
  has_many :players
end
