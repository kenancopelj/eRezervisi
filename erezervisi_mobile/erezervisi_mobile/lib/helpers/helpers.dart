class Helpers {
  static String formatPrice(num price) {
    return "$price KM";
  }

  static String getInitials(String fullName) {
    var fullNameSplitted = fullName.split(" ");
    var firstName = fullNameSplitted[0];
    var lastName = fullNameSplitted[1];

    return "${firstName[0]}${lastName[0]}";
  }
}
