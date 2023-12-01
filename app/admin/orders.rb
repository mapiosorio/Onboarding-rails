ActiveAdmin.register Order do
  permit_params :quantity, :total, :subtotal, :taxes, :surprise_delivery, :delivery_date, :delivery_time,
                :recipient_name, :recipient_phone_number, :rut, :company_name, :personalization_message,
                :delivery_direction, :re_delivery, :user_id, :product_id, :card_id, additional_ids: []

  index do
    selectable_column
    id_column
    column :user_id
    column :total
    column :product_id
    column :quantity
    column :delivery_time do |resource|
      resource.delivery_time.strftime('%H:%M %p')
    end
    column :delivery_date
    column :delivery_direction
    column :card_id
    actions
  end

  filter :user
  filter :product
  filter :quantity
  filter :total
  filter :re_delivery
  filter :delivery_date
  filter :delivery_time

  show do
    attributes_table do
      row :user
      row :product
      row :quantity
      row :total
      row :subtotal
      row :taxes
      row :surprise_delivery
      row :delivery_date
      row :delivery_time
      row :delivery_date
      row :recipient_name
      row :recipient_phone_number
      row :rut
      row :company_name
      row :personalization_message
      row :delivery_direction
      row :re_delivery
      row :created_at
      row :updated_at
      row :card
      row 'Adicionales' do |order|
        order.additionals.map do |additional|
          "#{additional.description} ($#{additional.price})"
        end.join('<br>').html_safe
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user
      f.input :product
      f.input :quantity
      f.input :subtotal
      f.input :taxes
      f.input :total
      f.input :rut
      f.input :company_name
      f.input :card

      f.inputs 'Información de la entrega' do
        f.input :recipient_name
        f.input :recipient_phone_number
        f.input :delivery_direction
        f.input :delivery_date
        f.input :delivery_time
        f.input :surprise_delivery
        f.input :re_delivery
      end

      f.inputs 'Personalización' do
        f.input :company_logo, as: :file
        f.input :personalization_message
      end

      f.inputs 'Adicionales' do
        f.input :additionals, as: :check_boxes, collection: Additional.all.map { |additional|
          ["#{additional.description} ($#{additional.price})", additional.id]
        }
      end
    end
    f.actions
  end
end
