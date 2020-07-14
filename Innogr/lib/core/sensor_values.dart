class User {
  final int id;
  final String phone;
  final String name;
  final String email;
  final String website;
  // Use a constructor to initialize all values
  User(this.id, this.phone, this.email, this.name, this.website);
}

class Photos {
  final int albumId;
  final int id;
  final String title;
  final String photo;
  final String thumbnail;

  Photos(this.albumId, this.id, this.title, this.photo, this.thumbnail);
}

class SensorValues {
  // this class will hold the constructor for the sensor values
  final int id;
  final String name;
  final String image;
  final String averageReading;
  final String status;

  SensorValues(
      this.id, this.name, this.image, this.averageReading, this.status);
}
