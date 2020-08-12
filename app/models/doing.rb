# frozen_string_literal: true

class Doing < ApplicationRecord
  belongs_to :user, counter_cache: :doing_count

  validates :title, presence: { message: "取り組み事項のタイトルは必須入力項目です" }
  validates :title, length: { maximum: 100, message: "タイトルは100文字以内にしてください" }
  validates :title, uniqueness: { message: "既に使用されているタイトルは登録できません" }
  validates :summary, length: { maximum: 1000, message: "概要は1000文字以内にしてください" }
end
