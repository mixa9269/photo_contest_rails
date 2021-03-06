# frozen_string_literal: true

ActiveAdmin.register Photo do
  index do
    selectable_column
    column :photo do |pg|
      image_tag pg.photo.thumb.url
    end
    column :title
    column 'Status', :aasm_state
    column 'Moderation', :moderation do |pg|
      columns do
        if pg.aasm_state == 'unapproved'
          column do
            link_to 'Approve', approve_admin_photo_path(pg)
          end
        else
          column do
            link_to 'Unapprove', unapprove_admin_photo_path(pg)
          end
        end
      end
    end
    actions
  end

  member_action :approve do
    resource.approve!
    redirect_to admin_photos_path
  end

  member_action :unapprove do
    resource.unapprove!
    redirect_to admin_photos_path
  end
end
