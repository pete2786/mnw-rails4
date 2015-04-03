function map_icon(icon){
  var icon_class;

  switch(icon) {
    case '01d':
      icon_class = 'wi-day-sunny';
      break;
    case '01n':
      icon_class = 'wi-night-clear';
      break;
    case '02d':
      icon_class = 'wi-day-sunny-overcast';
      break;
    case '02n':
      icon_class = 'night-partly-cloudy';
      break;
    case '03d':
      icon_class = 'wi-day-cloudy';
      break;
    case '03n':
      icon_class = 'wi-night-partly-cloudy';
      break;
    case '04d':
      icon_class = 'wi-day-cloudy';
      break;
    case '04n':
      icon_class = 'wi-night-cloudy';
      break;
    case '09d':
      icon_class = 'wi-showers';
      break;
    case '09n':
      icon_class = 'wi-night-showers';
      break;
    case '10d':
      icon_class = 'wi-rain';
      break;
    case '10n':
      icon_class = 'wi-night-rain';
      break;
    case '11d':
      icon_class = 'wi-thunderstorm';
      break;
    case '11n':
      icon_class = 'wi-night-alt-thunderstorm';
      break;
    case '13d':
      icon_class = 'wi-snow';
      break;
    case '13n':
      icon_class = 'wi-night-snow';
      break;
    case '50d':
      icon_class = 'wi-day-sprinkle';
      break;
    case '50n':
      icon_class = 'wi-night-sprinkle';
      break;
    default: 
      icon_class = 'wi-umbrella';
  }

  return icon_class;
}

function to_farenheit(t){
  return Math.round((t * (9.0/5))-459.67);
}
