ActiveAdmin.register Product do

  permit_params :image, :description, :name, :price, :provider_id, :category_id, :rating, :sharing, :vegan,
  :sugar_free, :gluten_free, :finger_food, additional_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :provider
    column :category
    column :rating
    column :created_at
    actions
  end

  filter :name
  filter :provider
  filter :category

  form do |f|
    f.inputs do
      f.input :image, as: :file
      f.input :name
      f.input :price
      f.input :provider
      f.input :category
      f.input :rating
      f.input :description, as: :ckeditor
      f.inputs 'Filters' do
        f.input :vegan
        f.input :sugar_free
        f.input :finger_food
        f.input :gluten_free
        f.input :sharing
      end

      f.inputs 'Additionals' do
        f.input :additionals, as: :check_boxes, collection: Additional.all.map { |additional| ["#{additional.description}
        ($#{additional.price})", additional.id] }
      end

    end
    f.actions
  end
end
