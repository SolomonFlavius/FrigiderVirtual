import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

exports.sendAlertForProductsSoonToExpire = functions.pubsub.schedule("0 6 * * *")
  .timeZone("Europe/Bucharest")
  .onRun((context) => {
    admin.firestore().collection("users").get()
      .then(users => {
        users.forEach(user => { // for each user check if they have products expiring soon
          const products_exp: String[] = []; // save the products names that are expiring soon
          const now_date: Date = new Date(); // get the current date

          // for each product check if it is expiring soon
          admin.firestore().collection("users").doc(user.id).collection("products").get()
            .then(products => {
              products.forEach(product => {
                const exp_date: Date = product.data().expiration_date.toDate();
                const days_difference: Number = Math.floor((exp_date.getTime() - now_date.getTime()) / (1000 * 3600 * 24));
                if (0 < days_difference && days_difference <= 3) { // if the product is expiring soon 
                  products_exp.push(product.data().name);
                }
              })
            })
            .catch(err => { // do nothing on error
            })
            .finally(() => { // after execution of get products send the notification if there are products expiring
              if (products_exp.length > 0) {
                admin.messaging().sendMulticast({
                  tokens: [user.data().fcm_token],
                  notification: {
                    title: "Product expiration alert",
                    body: "The following products will expire soon: " + products_exp.join(", ")
                  }
                });
              }
            });
        });
      });
    return null;
  });

exports.sendAlertForProductsExpired = functions.pubsub.schedule("0 6 * * *")
  .timeZone("Europe/Bucharest")
  .onRun((context) => {
    admin.firestore().collection("users").get()
      .then(users => {
        users.forEach(user => { // for each user check if they have products expiring soon
          const products_exp: String[] = []; // save the products names that are expiring soon
          const now_date: Date = new Date(); // get the current date

          // for each product check if it is expiring soon
          admin.firestore().collection("users").doc(user.id).collection("products").get()
            .then(products => {
              products.forEach(product => {
                const exp_date: Date = product.data().expiration_date.toDate();
                const days_difference: Number = Math.floor((exp_date.getTime() - now_date.getTime()) / (1000 * 3600 * 24));
                if (days_difference <= 0) { // if the product has expired
                  products_exp.push(product.data().name);
                }
              })
            })
            .catch(err => { // do nothing on error
            })
            .finally(() => { // after execution of get products send the notification if there are products expiring
              if (products_exp.length > 0) {
                admin.messaging().sendMulticast({
                  tokens: [user.data().fcm_token],
                  notification: {
                    title: "Product expiration alert",
                    body: "The following products have expired: " + products_exp.join(", ")
                  }
                });
              }
            });
        });
      });
    return null;
  });