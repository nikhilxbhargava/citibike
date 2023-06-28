#convert lat/long into m
distance_conversion <- function(lat1, lon1, lat2, lon2) {
  # Convert decimal degrees to radians
  lat1 <- lat1 * pi / 180
  lon1 <- lon1 * pi / 180
  lat2 <- lat2 * pi / 180
  lon2 <- lon2 * pi / 180
  
  # Earth radius in meters
  R <- 6371000
  
  # Calculate Haversine formula
  dlat <- lat2 - lat1
  dlon <- lon2 - lon1
  a <- sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2
  c <- 2 * asin(pmin(1, sqrt(a)))
  distance <- R * c
  
  return(distance)
}