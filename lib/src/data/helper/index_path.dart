
import 'package:flutter/material.dart';

class IndexPath {
  IndexPath(this.section, this.row, this.sub);
  int section;
  int row;
  int sub;
  @override
  String toString() {
    return section.toString()+row.toString()+sub.toString();
  }

  @override
  bool operator ==(o) => o is IndexPath && section == o.section && row == o.row && sub == o.sub;
  @override
  int get hashCode => hashValues(section, row, sub);
}