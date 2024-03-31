import 'package:uniconnect/services/notifications/notification_service.dart';
import 'package:uniconnect/services/notifications/awesome_noti_sender.dart';

class NotificationSenderService implements NotificationSender {
  final NotificationSender _notificationSender;

  const NotificationSenderService(this._notificationSender);

  factory NotificationSenderService.currentNotificationService() =>
      NotificationSenderService(AwesomeNotificationSender());

  @override
  Future<void> initialize() {
    return _notificationSender.initialize();
  }

  @override
  String truncateMessage(String message, int maxWords) {
    return _notificationSender.truncateMessage(message, maxWords);
  }

  @override
  void addNotificationToList(String message) {
    _notificationSender.addNotificationToList(message);
  }

  @override
  Future<void> sendConfirmationNotificationOnConnect(String user) {
    return _notificationSender.sendConfirmationNotificationOnConnect(user);
  }

  @override
  Future<void> sendConfirmationNotificationOnConnectWithBreaker(
      String user, String breakerMessage) {
    return _notificationSender.sendConfirmationNotificationOnConnectWithBreaker(
        user, breakerMessage);
  }
}
