class TravalModel {
  String name, detail, address, path;
  double lat, lng;

  TravalModel(
      this.name, this.detail, this.address, this.path, this.lat, this.lng);
  TravalModel.fromJson(Map<String, dynamic> map) {
    name = map['Name'];
    detail = map['Detail'];
    address = map['Address'];
    path = map['Path'];
    lat = map['Lat'];
    lng = map['Lng'];
  }
}
