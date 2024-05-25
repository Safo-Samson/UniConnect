class UserNotFoundAuthException implements Exception {}

// register exceptions
class WrongPasswordAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseAuthException implements Exception {}

// generic exceptions
class InvalidEmailAuthException implements Exception {}

class GenericAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class CouldNotGetUserNationalityException implements Exception {}

class CouldNotGetUserCourseException implements Exception {}

class CouldNotGetUserResidenceException implements Exception {}

class CouldNotGetUsersException implements Exception {}

class AllFiltersEmptyException implements Exception {}
