const functions = require("firebase-functions");
const express = require("express");
const admin = require("firebase-admin");
const { getMessaging } = require("firebase-admin/messaging");
const app = express();

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
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
    .then((response) => {
      functions.logger.info("notification send");
    })
    .catch((error) => {
      functions.logger.info("notification error");
    });

  res.sendStatus(200);
});

exports.wallpaper = functions.https.onRequest(app);
