# frozen_string_literal: true

class Doing < ApplicationRecord
  belongs_to :user, counter_cache: :doing_count

  validates :title, presence: true, message: "取り組み事項のタイトルは必須入力項目です"
  validates :title, length: { maximum: 100, message: "タイトルは%{length}文字以内にしてください" }
  validates :summary, length: { maximum: 1000, message: "概要は%{length}文字以内にしてください" }
end
