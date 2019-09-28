# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_28_194501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "arcs", force: :cascade do |t|
    t.string "name"
    t.bigint "position"
    t.string "url_slug"
    t.bigint "story_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["story_id"], name: "index_arcs_on_story_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "publication_order"
    t.string "title"
    t.text "content"
    t.bigint "publication_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["publication_id"], name: "index_pages_on_publication_id"
  end

  create_table "pictures", force: :cascade do |t|
    t.text "alt_text"
    t.bigint "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_pictures_on_page_id"
  end

  create_table "publications", force: :cascade do |t|
    t.datetime "published_at"
    t.bigint "arc_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["arc_id"], name: "index_publications_on_arc_id"
  end

  create_table "stories", force: :cascade do |t|
    t.string "name"
    t.string "url_slug"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "arcs", "stories"
  add_foreign_key "pages", "publications"
  add_foreign_key "pictures", "pages"
  add_foreign_key "publications", "arcs"

  create_view "page_positions", sql_definition: <<-SQL
      SELECT row_number() OVER () AS id,
      pages.id AS page_id,
      publication_positions."position" AS publication_position,
      publication_positions.publication_id,
      (arc_positions."position" + publication_positions."position") AS arc_position,
      arc_positions.arc_id,
      ((story_positions."position" + arc_positions."position") + publication_positions."position") AS story_position,
      story_positions.story_id
     FROM (((pages
       JOIN ( SELECT pages_1.id AS page_id,
              pages_1.publication_order AS "position",
              publications.id AS publication_id
             FROM (pages pages_1
               JOIN publications ON ((pages_1.publication_id = publications.id)))) publication_positions ON ((publication_positions.page_id = pages.id)))
       JOIN ( SELECT pages_1.id AS page_id,
              rolling_counts.previous_page_count AS "position",
              arcs.id AS arc_id
             FROM (((pages pages_1
               JOIN publications ON ((pages_1.publication_id = publications.id)))
               JOIN arcs ON ((publications.arc_id = arcs.id)))
               JOIN ( SELECT publications_1.id AS publication_id,
                      count(previous_pages.id) AS previous_page_count
                     FROM ((publications publications_1
                       LEFT JOIN publications previous_publications ON (((publications_1.arc_id = previous_publications.arc_id) AND (previous_publications.published_at < publications_1.published_at))))
                       LEFT JOIN pages previous_pages ON ((previous_pages.publication_id = previous_publications.id)))
                    GROUP BY publications_1.id) rolling_counts ON ((rolling_counts.publication_id = publications.id)))) arc_positions ON ((arc_positions.page_id = publication_positions.page_id)))
       JOIN ( SELECT pages_1.id AS page_id,
              COALESCE(rolling_counts.previous_page_count) AS "position",
              stories.id AS story_id
             FROM ((((pages pages_1
               JOIN publications ON ((pages_1.publication_id = publications.id)))
               JOIN arcs ON ((publications.arc_id = arcs.id)))
               JOIN stories ON ((arcs.story_id = stories.id)))
               LEFT JOIN ( SELECT arcs_1.id AS arc_id,
                      count(previous_pages.id) AS previous_page_count
                     FROM (((arcs arcs_1
                       LEFT JOIN arcs previous_arcs ON (((arcs_1.story_id = previous_arcs.story_id) AND (previous_arcs."position" < arcs_1."position"))))
                       LEFT JOIN publications previous_publications ON ((previous_publications.arc_id = previous_arcs.id)))
                       LEFT JOIN pages previous_pages ON ((previous_pages.publication_id = previous_publications.id)))
                    GROUP BY arcs_1.id) rolling_counts ON ((rolling_counts.arc_id = arcs.id)))) story_positions ON ((story_positions.page_id = arc_positions.page_id)));
  SQL
end
