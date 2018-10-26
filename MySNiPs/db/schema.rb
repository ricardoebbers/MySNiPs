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

ActiveRecord::Schema.define(version: 2018_10_13_172442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "genes", force: :cascade do |t|
    t.string "title", limit: 16, null: false
    t.string "rsid", limit: 13
    t.string "iid", limit: 13
    t.integer "chromosome", limit: 2
    t.string "position", limit: 10
    t.string "summary", limit: 200
    t.string "name", limit: 17
    t.boolean "orientation"
    t.boolean "stabilized"
    t.float "gmaf"
    t.string "revid", limit: 13
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_genes_on_title", unique: true
  end

  create_table "genotypes", force: :cascade do |t|
    t.string "title", limit: 160, null: false
    t.string "allele1", limit: 140
    t.string "allele2", limit: 140
    t.string "summary", limit: 280
    t.integer "repute", limit: 2
    t.float "magnitude"
    t.string "revid", limit: 13
    t.text "pageid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "page_content"
    t.bigint "gene_id"
    t.index ["gene_id"], name: "index_genotypes_on_gene_id"
    t.index ["title"], name: "index_genotypes_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "identifier", null: false
    t.bigint "password"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "genotypes", "genes", column: "gene_id"
end
