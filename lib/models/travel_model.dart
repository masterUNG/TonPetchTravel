class TravalModel {
  String name, detail, address, path, path2, path3, path4, path5, path6;
  double lat, lng;

  TravalModel(this.name, this.detail, this.address, this.path, this.path2,
      this.path3, this.path4, this.path5, this.path6, this.lat, this.lng);
  TravalModel.fromJson(Map<String, dynamic> map) {
    name = map['Name'];
    detail = map['Detail'];
    address = map['Address'];
    path = map['Path'];
    path2 = map['Path2'];
    path3 = map['Path3'];
    path4 = map['Path4'];
    path5 = map['Path5'];
    path6 = map['Path6'];
    lat = map['Lat'];
    lng = map['Lng'];
  }
}
