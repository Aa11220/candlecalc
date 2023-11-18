String printunits(num value) {
  if (value > 1000) {
    return "${(value / 1000).toStringAsFixed(2)} Kg";
  } else {
    return "${value.toStringAsFixed(2)} g";
  }
  //return " ${(value > 1000 ? (value / 1000) : value).toStringAsFixed(2)} ${value > 1000 ? 'kg' : 'g'}";
}
