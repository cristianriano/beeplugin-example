# frozen_string_literal: true

class CreateBeeTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :bee_templates do |t|
      t.string :name, index: { unique: true }
      t.text :content

      t.timestamps default: -> { 'CURRENT_TIMESTAMP' }
    end
  end
end
