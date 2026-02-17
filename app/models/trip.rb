# app/models/trip.rb
# app/models/trip.rb
class Trip < ApplicationRecord
  GRADES = {
    "A" => { label: "Excellent",           color: "#2D9D3A", min: 80, description: "Bravo ! Ce voyage est cohérent avec l'objectif 1.5°C. Vous avez trouvé un bel équilibre entre destination engagée, transport raisonnable et durée de séjour adaptée." },
    "B" => { label: "Bon",                 color: "#7BBF2A", min: 60, description: "C'est un voyage plutôt responsable. Quelques ajustements — un séjour un peu plus long ou un transport alternatif — pourraient encore améliorer son bilan." },
    "C" => { label: "Moyen",               color: "#F5C542", min: 40, description: "Ce voyage n'est pas idéal sur le plan climatique, mais ce n'est pas une impasse. Voyez ci-dessous les leviers concrets pour réduire son empreinte tout en profitant de votre destination." },
    "D" => { label: "Faible",         color: "#E8822A", min: 20, description: "L'empreinte de ce voyage est importante. Cela ne veut pas dire qu'il faut y renoncer, mais il mérite d'être repensé : durée, transport ou destination — chaque levier compte." },
    "E" => { label: "Très faible",    color: "#C62828", min: 0,  description: "Ce voyage a une empreinte très lourde. On comprend l'envie de partir, mais en l'état il s'éloigne beaucoup de l'objectif 1.5°C. Explorez les alternatives proposées ci-dessous." }
  }.freeze

  belongs_to :user
  belongs_to :destination, optional: true
  belongs_to :country
  belongs_to :transport_mode
end
