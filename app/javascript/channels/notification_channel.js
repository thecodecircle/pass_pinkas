import consumer from "./consumer"

consumer.subscriptions.create("NotificationChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data);
    if (Notification.permission === 'granted') {
      navigator.serviceWorker.ready.then(function(registration) {
        registration.showNotification('קשל"פ', {
          body: data[0],
          vibrate: [200, 100, 200, 100, 200, 100, 200],
          tag: 'Kashlapp',
          icon: data[1],
          badge: data[2],
          sound: data[3]
        });
      });
      // var title = 'Push Notification'
      // var body = data
      // var options = { body: body }
      // new Notification(title, options)
    }
  }
});


// navigator.serviceWorker.register('sw.js');
//
// function showNotification() {
//   Notification.requestPermission(function(result) {
//     if (result === 'granted') {
//
//     }
//   });
// }
