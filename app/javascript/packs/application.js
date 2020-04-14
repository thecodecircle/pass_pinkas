// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")

if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
    .then(function(reg) {
      console.log('[Companion]', 'Service worker registered!');
      console.log(reg);
    });
}

Notification.requestPermission().then(function (result) {})

// {
//   "subject": "mailto:yarden11111@gmail.com",
//   "publicKey": "BCwnKrGqduNJmswZUbQi4YvvfA4PJG9z7xmHtTSvxfru0ACdxlCZkmykt0wvXXeRoed-WrR7YJmwAAXhBlNPW3k",
//   "privateKey": "SpswtsEMyMBo8weymdevJmN-jRsPoBhZC9m-YgU2V24"
// }

// window.vapidPublicKey = new Uint8Array(<%= Base64.urlsafe_decode64("BCwnKrGqduNJmswZUbQi4YvvfA4PJG9z7xmHtTSvxfru0ACdxlCZkmykt0wvXXeRoed-WrR7YJmwAAXhBlNPW3k").bytes %>);

navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
  serviceWorkerRegistration.pushManager
  .subscribe({
    userVisibleOnly: true,
    applicationServerKey: "BCwnKrGqduNJmswZUbQi4YvvfA4PJG9z7xmHtTSvxfru0ACdxlCZkmykt0wvXXeRoed-WrR7YJmwAAXhBlNPW3k"
  }).then(console.log("JS Subscribe"))
});

// require( 'datatables.net-dt' );
// require( 'datatables.net-fixedheader-dt' );
// require( 'datatables.net-responsive-dt' );
// require( 'datatables.net-searchpanes-dt' );


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "stylesheets/application"
