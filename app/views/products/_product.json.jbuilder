json.extract! product, :id, :sub_category_id, :name, :image, :price, :rating, :description, :comment, :created_at, :updated_at
json.url product_url(product, format: :json)
