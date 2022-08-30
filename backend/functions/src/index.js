const functions = require("firebase-functions");
const express = require("express");
const admin = require("firebase-admin");
const { getMessaging } = require("firebase-admin/messaging");
const app = express();

const serviceAccount = require("../fpaper-7a90f-firebase-adminsdk-kq5bg-098655f915.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

app.post("/android", (req, res) => {
  const message = {
    data: {
      url: req.body.url,
    },
    token: req.body.registrationToken,
  };

  getMessaging()
    .send(message)
    .then((_) => {
      functions.logger.info("notification send");
    })
    .catch((_) => {
      functions.logger.info("notification error");
    });

  res.sendStatus(200);
});

exports.wallpaper = functions.https.onRequest(app);
