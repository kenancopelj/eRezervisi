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

  static String getMonthName(int month) {
    switch (month) {
      case 1:
        return "Januar";
      case 2:
        return "Februar";
      case 3:
        return "Mart";
      case 4:
        return "April";
      case 5:
        return "Maj";
      case 6:
        return "Juni";
      case 7:
        return "Juli";
      case 8:
        return "August";
      case 9:
        return "Septembar";
      case 10:
        return "Oktobar";
      case 11:
        return "Novembar";
      case 12:
        return "Decembar";
      default:
        return "";
    }
  }
}
