import 'dart:io';

import 'package:geocoder_offline/geocoder_offline.dart';
import 'package:test/test.dart';

void main() {
  test('Test distance', () {
    final distance = GeocodeData.calculateDistance(49, -121, 49.2, -121.2);

    // distance is 16.517293271014562
    expect(distance, allOf([greaterThan(16), lessThan(17)]));
  });

  test('Test geocoding usgs', () {
    var geocoder = GeocodeData(
        File(Directory.current.path + '/example/NationalFedCodes_20191101.csv')
            .readAsStringSync(),
        'FEATURE_NAME',
        'STATE_ALPHA',
        'PRIMARY_LATITUDE',
        'PRIMARY_LONGITUDE',
        'TIMEZONE',
        fieldDelimiter: ',',
        eol: '\n',
        numMarkers: 1);

    var result = geocoder.search(41.881832, -87.623177);
    expect(result.length, 1);
    expect(result.first.distance.toInt(), 1);
    expect(result.first.bearing, 'ESE');
    expect(result.first.location.featureName, 'Cook County');
    expect(result.first.gnisFormat.trim(), '1mi ESE of Cook County, IL');
  });

  test('Test geocoding geonames', () {
    var geocoder = GeocodeData(
        File(Directory.current.path + '/example/cities15000.txt')
            .readAsStringSync(),
        'name',
        'country code',
        'latitude',
        'longitude',
        'timezone',
        fieldDelimiter: '\t',
        eol: '\n',
        numMarkers: 1);

    var result = geocoder.search(41.881832, -87.623177);

    expect(result.length, 1);
    expect(result.first.distance.toInt(), 0);
    expect(result.first.bearing, 'E');
    expect(result.first.location.featureName, 'Chicago Loop');
    expect(result.first.location.timezone, 'America/Chicago');
    expect(result.first.gnisFormat.trim(), 'Chicago Loop, US');
  });
}
