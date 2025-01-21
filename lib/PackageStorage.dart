class PackageStorage {
  static final Set<String> _deliveredPackageIds = {};

  static bool isNewPackage(dynamic package) {
    return !_deliveredPackageIds.contains(package['id'].toString());
  }

  static void addPackages(List<dynamic> packages) {
    _deliveredPackageIds.addAll(packages.map((p) => p['id'].toString()));
  }
}

