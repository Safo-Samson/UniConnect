const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

const messaging = admin.messaging();

// Function to send a notification to a specific topic
async function sendNotificationToTopic(topic, title, body) {
  const message = {
    data: {
      title: title,
      body: body,
    },
    topic: topic,
  };

  try {
    await messaging.send(message);
    console.log("Notification sent successfully.");
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

module.exports = {
  sendNotificationToTopic,
};
