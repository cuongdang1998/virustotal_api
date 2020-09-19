import 'package:flutter/material.dart';
import 'package:virus_total_api/models/file_scan.dart';
import 'package:virus_total_api/screens/file/scan_card.dart';

import '../../size_config.dart';

class ScanCardList extends StatelessWidget {
  const ScanCardList({
    Key key, this.scans,
  }) : super(key: key);
  final List<Scan> scans;
  @override
  Widget build(BuildContext context) {
    var defaultSize=SizeConfig.defaultSize;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultSize*2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(scans.length, (index) => ScanCard(scan: scans[index], index: index,)),
      ),
    );
  }
}