'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "36353f9a1976f9bb41a8f72712564d64",
"assets/AssetManifest.json": "a49c7c0f34f4830e0e61d9951b2aa397",
"assets/assets/images/about_us_text.png": "d72282daa629bd1aea81d1838c4e7c79",
"assets/assets/images/arrow_right.png": "3a9fb519ad16f50d9e33db417dc94086",
"assets/assets/images/impact_lines.png": "9ef8cf5421af5888230b3bd730ed32f0",
"assets/assets/images/logo.png": "0482e4310f3697228e0586386fc14324",
"assets/assets/images/mercuries.png": "f3188735fec96ab2b4687f93b6627a37",
"assets/assets/images/mercury.png": "8053f840b18bb665df7d49cc8640f28e",
"assets/assets/images/mobile_about_us_text.png": "c56c9ee29259f9c9d5b438fe77fef671",
"assets/assets/images/moon.png": "db64bd084cc3fe604783f9e065aaf8bb",
"assets/assets/images/office.png": "a1cfa6303f688e096dbc2b3562492b5c",
"assets/assets/images/optimis.png": "d0099e4f0c940716f8beff693cee308b",
"assets/assets/images/optimis_mobile.png": "492424fabe4bdd478d45cc5606426281",
"assets/assets/images/our_services_text.png": "4eddfa7b89db22605d5bd9743ca0df8b",
"assets/assets/images/our_space_text.png": "c98fa6b78710a434b3e7ea3a13766de5",
"assets/assets/images/screens.png": "1756f707ff55553ebb47856b54c01b4f",
"assets/assets/images/short_arrow_left.png": "7f11ed180f9ef0d5c78a59dff6a897e0",
"assets/assets/images/small_mercury.png": "059af3e800a4f26cb20008de5362dfaf",
"assets/assets/images/text_group.png": "3278f031dcd8a4219c784c903545b14b",
"assets/assets/images/venus_mercury.png": "742dbcc0acdf56a10fb01354a8bfacc0",
"assets/assets/images/zognest_team.png": "dbc73c161e5fb6954df89feb8e272dad",
"assets/assets/svg/arrow_down.svg": "baae1d2a95958e3180db09f5362a94fb",
"assets/assets/svg/arrow_up.svg": "f5da3e8c94c99a4204b786712856a846",
"assets/assets/svg/discord.svg": "bd1edb35f7833ee891224383855a56ce",
"assets/assets/svg/drawer.svg": "2b7a5583a83c1d086a75271bf373e53f",
"assets/assets/svg/dribble.svg": "ac9bb3c9076ad86de6639bf29635f823",
"assets/assets/svg/facebook.svg": "23294b3ca3d9d7fc1879389c54b66290",
"assets/assets/svg/figma.svg": "82b56f63a7c337196f653ef52115acbc",
"assets/assets/svg/grid_lines.svg": "ab15c6329aacefe7ab7ba6fb18e09443",
"assets/assets/svg/hamburger.svg": "2adf2206355e72deb6bcb379338e7886",
"assets/assets/svg/impact_lines.svg": "6304a4de82f813b111d546f567922264",
"assets/assets/svg/instagram.svg": "08a4bd9860e7c9ca57a75232b3a54cd6",
"assets/assets/svg/linkedin.svg": "9c9d518baaec810e02dd5f1eaf33504c",
"assets/assets/svg/logo.svg": "2e08154daaaec5e66a830f129678639a",
"assets/assets/svg/mail.svg": "2c71094ea9595fab43157cba475e8592",
"assets/assets/svg/pintrest.svg": "8336d080eb7dff19f484f9976229733c",
"assets/assets/svg/whatsapp.svg": "8a04e054c4a6d3989abe76e13722f1d2",
"assets/assets/svg/youtube.svg": "777f45b0902ea04d264e6f4eb3d75433",
"assets/FontManifest.json": "8c6e5e8414e08bf85bc2ae58ba10c2c0",
"assets/fonts/MaterialIcons-Regular.otf": "d6f7c13537dfed0a60b0ec433c6564c1",
"assets/fonts/Oswald/Oswald-Variable.ttf": "033f2e7815bfa96db10bbb07ca20fb93",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Black.otf": "41cd4e684cec8b6fa83aaada8bad8873",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Bold.otf": "bf108f8e2fcbda9e4ea2b18ed7799caf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Light.otf": "5d6b13c011fc2e019e5276b4ae744bdf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Medium.otf": "137ee8cda3c7f9c388e62aca25c82744",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Regular.otf": "6720e086a89d34cb9ca424a3ba913082",
"assets/fonts/SFProRounded/SF-Pro-Rounded-SemiBold.otf": "02dc9f029efbbe4cd105420f50202dd9",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Thin.otf": "f8ab0e64878f5c5e3db454b6f89dd0cd",
"assets/NOTICES": "9e3302ccc86f1c7cce274d28574d79e3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "218cc6cda8bb3a870e959fe98a4e325f",
"/": "218cc6cda8bb3a870e959fe98a4e325f",
"main.dart.js": "2d4c58a612d4519699a148ef7d1c3fde",
"manifest.json": "3e56b70d98af4acf35448515d5aa6c39",
"version.json": "c9a57fded59c1038f8ee06dc3f0160bc"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
