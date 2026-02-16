class Trip < ApplicationRecord
  GRADES = {
    "A" => { label: "Excellent",     color: "#2D9D3A", min: 80, description: "Ce voyage est aligné avec l'objectif 1.5°C" },
    "B" => { label: "Bon",           color: "#7BBF2A", min: 60, description: "Ce voyage est presque compatible avec l'objectif 1.5°C" },
    "C" => { label: "Moyen",         color: "#F5C542", min: 40, description: "Ce voyage a un impact significatif — des alternatives existent" },
    "D" => { label: "Élevé",         color: "#E8822A", min: 20, description: "Ce voyage a un impact important sur le climat" },
    "E" => { label: "Très élevé",    color: "#C62828", min: 0,  description: "Ce voyage est incompatible avec l'objectif 1.5°C" }
  }.freeze

  belongs_to :user
  belongs_to :destination, optional: true
  belongs_to :country
  belongs_to :transport_mode
  belongs_to :user
  belongs_to :destination
  belongs_to :country
  belongs_to :transport_mode
end
