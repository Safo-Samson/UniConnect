import 'package:cloud_firestore/cloud_firestore.dart';

class GroupDetails {
  String groupId;
  String groupName;
  String numberOfMembers;

  GroupDetails({
    required this.groupId,
    required this.groupName,
    required this.numberOfMembers,
  });

  factory GroupDetails.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return GroupDetails(
      groupId: snapshot.data()['groupId'] ?? ' No group ID',
      groupName: snapshot.data()['groupName'] ?? '',
      numberOfMembers: snapshot.data()['numberOfMembers'] ?? '',
    );
  }

  factory GroupDetails.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return GroupDetails(
      groupId: snapshot.data()?['groupId'] ?? 'No group ID',
      groupName: snapshot.data()?['groupName'] ?? '',
      numberOfMembers: snapshot.data()?['numberOfMembers'] ?? '',
    );
  }
}
