class CreatePlantsService
  def call
    Plant.delete_all
    ActiveRecord::Base.connection.execute("ALTER SEQUENCE plants_id_seq RESTART WITH 1")
    Plant.create!(name: "Small Tree", price: 500, detail: "This is a small tree", image: "tree-small.png")
    Plant.create!(name: "Medium Tree", price: 1000, detail: "This is a medium tree", image: "tree-medium.png")
    Plant.create!(name: "Large Tree", price: 1500, detail: "This is a large tree", image: "tree-large.png")
  end
end
