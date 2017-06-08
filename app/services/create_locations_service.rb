class CreateLocationsService
  def call
    # create Haryali locations
    HaryaliLocation.create(address: "Attribe Solution, Caeser's Tower, Sharah-e-Faisal Karachi",lat: "24.862630",lng: "67.045820")
  end
end
