class CloudStorageException implements Exception {
  const CloudStorageException();
}

// this is C in crud

// this is R in crud
class CouldNotGetAllNationalityException extends CloudStorageException {}

class CouldNotGetAllResidenceException extends CloudStorageException {}

class CouldNotGetAllUsersException extends CloudStorageException {}

class CouldNotGetAllCoursesException extends CloudStorageException {}

class CouldNotGetUser extends CloudStorageException {}

// this is U in crud
class CouldNotUpdateUserRecordException extends CloudStorageException {}

// this is D in crud

