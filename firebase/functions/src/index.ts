import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
// import { QueryDocumentSnapshot } from "firebase-functions/v1/firestore";
import { EventContext } from "firebase-functions";
import * as sendgrid from '@sendgrid/mail';
import { MailDataRequired } from "@sendgrid/mail";
import { generateEmail } from "./email";

admin.initializeApp();

const firestore = admin.firestore();
const messaging = admin.messaging();

interface Notification {
  type: 'email' | 'push';
  deviceToken?: string;
  domain: string;
  expirationDateTime: string;
  status?: 'queued' | 'failed' | 'success' | 'cancelled';
  email?: string;
}

const deviceToken = 'cc6Qo3nzS96lG8oKu3w3ly:APA91bHjGupbyL-fYGEGbqWmRNj5y0zsCMAPXj9MT1jkc8BR3V-YI7A_Uku77JUMdt8qqeWHi2VDKx7imSdVN-mfgvCmFu6zCFY0clsfEOh7tftkNgp0LUcVb391PflwBVAXCK8UHa3g';
const email = 'boriszivk@gmail.com'
const email2 = 'lukastajcic@gmail.com'

const dataToSeed: Notification[] = [
  {
    type: 'push',
    deviceToken: deviceToken,
    domain: 'prioritysoft.io',
    expirationDateTime: new Date().toISOString(),
    status: 'queued'
  },
  {
    type: 'push',
    deviceToken: deviceToken,
    domain: 'prioritysoft.rs',
    expirationDateTime: new Date().toISOString(),
    status: 'queued'
  },
  {
    type: 'email',
    email: email,
    domain: 'prioritysoft.rs',
    expirationDateTime: new Date().toISOString(),
    status: 'queued'
  },
  {
    type: 'email',
    email: email2,
    domain: 'prioritysoft.io',
    expirationDateTime: new Date().toISOString(),
    status: 'queued'
  },
];

export const seedData = functions.https.onRequest(async (req, res) => {
  for (const item of dataToSeed) {
    await firestore.collection('notifications')
      .add(item);
  }
  res.send(200);
});

export const sendNotificationsApi = functions.https.onRequest(async (req, res) => {
  await sendNotifications();
  res.send(200);
});

const sendNotifications = async (context?: EventContext) => {
  // .onRequest(async (req, res) => {
  try {
    const baseQuery = firestore.collection('notifications')
      .where('expirationDateTime', '<=', new Date().toISOString());

    const queuedNotifciations = await baseQuery
      .where('status', '==', 'queued')
      .get();

    const failedNotifciations = await baseQuery
      .where('status', '==', 'failed')
      .get();

    for (const notification of queuedNotifciations.docs)
      await notification.ref.set({ status: 'failed' }, { merge: true });

    const notificationsToSend = [
      ...queuedNotifciations.docs,
      ...failedNotifciations.docs,
    ];

    const pushNotificationsToSend = [];
    const pushNotificationDocumentsToUpdate = [];

    const emailNotificationsToSend: MailDataRequired[] = [];
    const emailNotificationDocumentsToUpdate = [];

    for (const notificationDoc of notificationsToSend) {
      const notification = notificationDoc.data() as Notification;

      switch (notification.type) {
        case 'email':
          if (!notification.email)
            continue;

          const date = new Date(notification.expirationDateTime).toLocaleDateString();

          emailNotificationsToSend.push({
            to: notification.email,
            from: 'whois-madjije@prioritysoft.io',
            subject: `Upozorenje: domen ${notification.domain} je istekao`,
            text: `Obaveštenje o isteku domena. Poštovani obaveštavamo Vas da je prioritysoft.rs domen istekao, ukoliko želite da obnovite domen molimo Vas odgovorite nam na ovaj mejl... Datum isteka ${date}`,
            html: generateEmail(notification.domain, date),

          } as MailDataRequired);

          emailNotificationDocumentsToUpdate.push(notificationDoc);

          break;

        case 'push':
          console.log('push notif')
          const data = notificationDoc.data() as Notification;
          console.log(data.deviceToken)

          if (!data.deviceToken)
            continue;

          pushNotificationsToSend.push(constructPushNotification(data));
          pushNotificationDocumentsToUpdate.push(notificationDoc);

          console.log(constructPushNotification(data));

          break;
      }
    }

    if (pushNotificationsToSend.length > 0) {
      console.log('sending messages')
      await messaging.sendAll(pushNotificationsToSend);

      for (const notification of pushNotificationDocumentsToUpdate) {
        await notification.ref.set({ 'status': 'success' }, { merge: true });
      }
    }

    if (emailNotificationsToSend.length > 0) {
      sendgrid.setApiKey('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');
      await sendgrid.send(emailNotificationsToSend, true);

      for (const notification of emailNotificationDocumentsToUpdate) {
        await notification.ref.set({ 'status': 'success' }, { merge: true });
      }
    }
    // res.send(200);
  } catch (e) {
    console.log(e);
  }
};


export const sendNotificationsTest = functions.pubsub.schedule('0 19 * * *')
  .onRun(sendNotifications);

export const sendNotificationsFirst = functions.pubsub.schedule('5 4 * * *')
  .onRun(sendNotifications);

export const sendNotificationsSecond = functions.pubsub.schedule('5 6 * * *')
  .onRun(sendNotifications);

export const sendNotificationsThird = functions.pubsub.schedule('5 7 * * *')
  .onRun(sendNotifications);

const constructPushNotification = (data: Notification) => {
  return {
    token: data.deviceToken!,
    android: {},
    notification: {
      title: `Domen ${data.domain} je istekao ${data.expirationDateTime}`,
      body: 'Kliknite na obavestenje kako biste usli u aplikaciju'
    },
  }
}
