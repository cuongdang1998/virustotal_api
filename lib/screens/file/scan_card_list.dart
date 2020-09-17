import 'package:flutter/material.dart';
import 'package:virus_total_api/models/file_scan.dart';

class ScanCardList extends StatelessWidget {
  const ScanCardList({
    Key key, this.scans,
  }) : super(key: key);
  final List<Scan> scans;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(scans.length, (index) => ScanCard(scan: scans[index],)),
    );
  }
}
class ScanCard extends StatelessWidget {
  const ScanCard({
    Key key,
    @required this.scan,
  }) : super(key: key);

  final Scan scan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0,10),
                color: Colors.grey.withOpacity(.2),
                blurRadius: 20
            ),
          ]
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(scan.keyscan, style: Theme.of(context).textTheme.headline6,),
          Text(scan.result ?? "",),
          Text(scan.version ?? "",),
        ],
      ),
    );
  }
}