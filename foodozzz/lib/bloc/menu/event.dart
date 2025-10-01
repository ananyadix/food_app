abstract class MenuEvent{}
class FetchMenu extends MenuEvent{
  final String restId;
  FetchMenu(this.restId);
}