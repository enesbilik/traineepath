class UserValidateMixin {
  nameValidate(String value) {
    if (value.isEmpty) {
      return "Value is empty";
    } else if (value.length <= 2) {
      return "Name should be bigger than 2";
    }
    return null;
  }
}
