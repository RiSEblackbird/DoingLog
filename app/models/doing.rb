# frozen_string_literal: true

class Doing < ApplicationRecord
  belongs_to :user, counter_chache: :article_count

  validates :title, :body, presence: true
  validates :title, length: { maximum: 100 }
  validates :summary, length: { maximum: 1000 }
end
