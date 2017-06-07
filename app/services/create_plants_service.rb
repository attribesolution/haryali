class CreatePlantsService
  def call
    plant = Plant.create!(name: "Plant 1", price: 500, detail: "Lorem ipsum")
    plant = Plant.create!(name: "Plant 2", price: 1500, detail: "Lorem ipsum")
    plant = Plant.create!(name: "Plant 3", price: 2000, detail: "Lorem ipsum")
  end
end
