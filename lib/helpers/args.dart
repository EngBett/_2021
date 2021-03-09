class DetailArgs{
  final String gender;
  final String groupId;
  DetailArgs(this.gender, this.groupId);
}

class SignUpArgs{
  final DetailArgs detailArgs;
  final String firstName;
  final String lastName;
  final String dob;
  final String phoneNumber;

  SignUpArgs(this.detailArgs, this.firstName, this.lastName, this.dob, this.phoneNumber);
}