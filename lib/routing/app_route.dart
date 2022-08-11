enum AppRoute {
  login("/login"),
  home("/home"),
  device("/device");

  final String path;
  const AppRoute(this.path);
}
