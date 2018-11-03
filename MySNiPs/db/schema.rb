# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_03_175851) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer "user_id"
    t.integer "genotype_id"
    t.index ["user_id", "genotype_id"], name: "index_cards_on_user_id_and_genotype_id", unique: true
  end

  create_table "genes", force: :cascade do |t|
    t.string "title", limit: 14, null: false
    t.string "rsid", limit: 11
    t.string "iid", limit: 11
    t.string "chromosome", limit: 2
    t.string "position", limit: 10
    t.string "summary", limit: 180
    t.string "name", limit: 16
    t.boolean "orientation"
    t.boolean "stabilized"
    t.float "gmaf"
    t.string "revid", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_genes_on_title", unique: true
  end

  create_table "genomas", force: :cascade do |t|
    t.string "status"
    t.string "log_error"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genotypes", force: :cascade do |t|
    t.string "title", limit: 18, null: false
    t.string "allele1", limit: 1
    t.string "allele2", limit: 1
    t.string "summary", limit: 280
    t.integer "repute", limit: 2
    t.float "magnitude"
    t.string "revid", limit: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "page_content"
    t.bigint "gene_id"
    t.string "pageid", limit: 7
    t.index ["gene_id"], name: "index_genotypes_on_gene_id"
    t.index ["title"], name: "index_genotypes_on_title", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "role_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_login"
    t.integer "role_id"
    t.index ["identifier"], name: "index_users_on_identifier", unique: true
  end

  add_foreign_key "cards", "genotypes"
  add_foreign_key "cards", "users"
  add_foreign_key "genomas", "users"
  add_foreign_key "genotypes", "genes"
  add_foreign_key "users", "roles"
end
