class Contributor {
  String name;
  String email;
  String linkedIn;

  Contributor({required this.name, required this.email, required this.linkedIn});

}

final List<Contributor> contributors = <Contributor>[
  Contributor(
      name: 'André Masson', email: 'amwebexpert@gmail.com', linkedIn: 'https://www.linkedin.com/in/amwebexpert'),
];
