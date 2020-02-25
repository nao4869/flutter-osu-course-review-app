import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Institution with ChangeNotifier {
  final String id;
  final String name;
  final String country;
  final String state;
  final String city;
  final String logo;
  final String videoUrl;

  Institution({
    @required this.id,
    @required this.name,
    @required this.country,
    @required this.state,
    @required this.city,
    @required this.logo,
    this.videoUrl = 'https://video-nrt1-1.xx.fbcdn.net/v/t39.24130-2/10000000_2568142483461739_1418694443058507705_n.mp4?_nc_cat=109&_nc_sid=985c63&efg=eyJ2ZW5jb2RlX3RhZyI6Im9lcF9oZCJ9&_nc_ohc=ygi-aH-NMz0AX8znClY&_nc_ht=video-nrt1-1.xx&oh=d17fe15021f41290c99dc5f204fe0b09&oe=5F030D51',
  });
}
