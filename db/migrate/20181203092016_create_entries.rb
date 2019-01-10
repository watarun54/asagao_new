class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.references :member, null: false
      t.string :title, null: false
      t.string :body
      t.datetime :posted_at, null: false
      t.string :status, null: false, default: "draft" # "draft"（下書き）"member_only"（会員限定）"public"（公開）

      t.timestamps
    end
  end
end
