
import 'package:flutter/material.dart';

class IndexPath {
  IndexPath(this.section, this.row);
  int section;
  int row;
  @override
  String toString() {
    return section.toString()+row.toString();
  }

  @override
  bool operator ==(o) => o is IndexPath && section == o.section && row == o.row;
  @override
  int get hashCode => hashValues(section, row);
}