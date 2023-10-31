ActiveAdmin.register User do

  permit_params :email, :encrypted_password, :password, :password_confirmation, :name, :surname, :company, :position, :photo

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :photo, as: :file
      f.input :name
      f.input :surname
      f.input :email
      f.input :company
      f.input :position
      if f.object.new_record?
        f.input :password
      end
    end
    f.actions
  end
end
