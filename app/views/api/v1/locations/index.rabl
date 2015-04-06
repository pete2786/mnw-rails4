collection locations

attributes :id, :value, :lat, :long
node(:lat){|location| location.lat.to_f }
node(:long){|location| location.long.to_f }
