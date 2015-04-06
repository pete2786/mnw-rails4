collection locations

attributes :id, :value, :population
node(:lat){|location| location.lat.to_f }
node(:long){|location| location.long.to_f }
