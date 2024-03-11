abstract class NotificationSender {
  Future<void> initialize();

  Future<void> sendConfirmationNotificationOnConnect(String user);

  Future<void> sendConfirmationNotificationOnConnectWithBreaker(
      String user, String breakerMessage);

  void addNotificationToList(String message);

  String truncateMessage(String message, int maxWords);
}
