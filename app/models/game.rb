class Game < ApplicationRecord
  belongs_to :uploaded_log
  has_many :kill_by_means, dependent: :destroy
  has_many :players, dependent: :destroy
end
