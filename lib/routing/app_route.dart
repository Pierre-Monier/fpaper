enum AppRoute {
  login("/login"),
  home("/home");

  final String path;
  const AppRoute(this.path);
}
