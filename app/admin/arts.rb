ActiveAdmin.register Art do
  index do
    column :id
    column :name
    column :template
    column :club_id
    column :template_id
    column :enabled
    default_actions
  end

form do |f|
    f.inputs "Art Details" do
      f.input :name
    end
    f.buttons
  end
  
end
