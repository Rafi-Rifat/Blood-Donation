import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371; // Earth's radius in kilometers

  // Convert latitude and longitude from degrees to radians
  lat1 = _degreesToRadians(lat1);
  lon1 = _degreesToRadians(lon1);
  lat2 = _degreesToRadians(lat2);
  lon2 = _degreesToRadians(lon2);

  // Haversine formula
  final dLat = lat2 - lat1;
  final dLon = lon2 - lon1;

  final a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // Calculate the distance
  final distance = earthRadius * c;
  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * (pi / 180);
}

