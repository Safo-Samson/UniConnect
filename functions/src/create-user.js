const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { sendNotificationToTopic } = require("./notifications");

admin.initializeApp();

const firestore = admin.firestore();

exports.processNewUserSignup = functions.auth.user().onCreate(async (user) => {
  const { uid, username, nationality, course } = user;

  // 1. Query the Firestore for similar nationality users
  const newUser = { uid, username, nationality, course };
  const similarUsersQuery = firestore
    .collection("users")
    .where("nationality", "==", newUser.nationality)
    .orderBy("nationality")
    .orderBy("course")
    .orderBy("year")
    .limit(10);

  const similarUsersSnapshot = await similarUsersQuery.get();
  const similarUsers = similarUsersSnapshot.docs.map((doc) => doc.data());

  // 2. Adding new user to FMS queue for notification
  const topic = newUser.nationality;
  const notificationTitle = "You might have a new friend!";
  const notificationBody = `Connect with ${newUser.username}, who is from ${newUser.nationality} 
                            and studies ${newUser.course} !`;

  await sendNotificationToTopic(topic, notificationTitle, notificationBody);

  return { similarUsers }; // Return the similar users upon deploying the function
});
