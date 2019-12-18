import 'dart:io';

import 'package:geocoder_offline/geocoder_offline.dart';

void main() {
  var geocoder = GeocodeData(
      File(Directory.current.path + '/example/NationalFedCodes_20191101.csv').readAsStringSync(),
      'FEATURE_NAME',
      'STATE_ALPHA',
      'PRIMARY_LATITUDE',
      'PRIMARY_LONGITUDE',
      fieldDelimiter: ',',
      eol: '\n');

  var result = geocoder.search(41.881832, -87.623177);
  print(result.first.gnisFormat);
}
