class AddAttachmentDocumentToOrganizations < ActiveRecord::Migration
  def self.up
    change_table :organizations do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :organizations, :document
  end
end
