'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4a4fba69f497e36982b4f7e22a7aa6d6",
"assets/AssetManifest.bin.json": "9b574f184cd9902f0b5de957af060e9e",
"assets/AssetManifest.json": "68b98ff4ff92b1474e51f5d914b29967",
"assets/assets/images/about_us_text.png": "d72282daa629bd1aea81d1838c4e7c79",
"assets/assets/images/arrow_right.png": "3a9fb519ad16f50d9e33db417dc94086",
"assets/assets/images/impact_lines.png": "9ef8cf5421af5888230b3bd730ed32f0",
"assets/assets/images/logo_new.png": "717e5372c4ca7caa44211c009051b772",
"assets/assets/images/mercuries.png": "935c626ee5665af6d8fd124ace3e8a65",
"assets/assets/images/mercury.png": "a67e05e8bbef7e5302348bd48e739f88",
"assets/assets/images/mercury_mobile.png": "22a4f3ef6c15ce8a2f3980e863b9445e",
"assets/assets/images/mobile_about_us_text.png": "fdf2388ff63eda3efeec6d8c9b4f11bb",
"assets/assets/images/moon.png": "db64bd084cc3fe604783f9e065aaf8bb",
"assets/assets/images/office.png": "a1cfa6303f688e096dbc2b3562492b5c",
"assets/assets/images/optimis.png": "d0099e4f0c940716f8beff693cee308b",
"assets/assets/images/optimis_mobile.png": "492424fabe4bdd478d45cc5606426281",
"assets/assets/images/our_project_mobile.png": "7d70beb304c00815d834f179311c97ff",
"assets/assets/images/our_services_text.png": "bf9c1ea1538b45e0d9392a8391d33c83",
"assets/assets/images/our_services_text_mobile.png": "e50a338c6b28e72ca478ec9fb4479a16",
"assets/assets/images/our_space_mobile.png": "39065500dbf752efa845f30776b9977b",
"assets/assets/images/our_space_text.png": "9d6f53c3012ff437ae8ee713a9239b51",
"assets/assets/images/screens.png": "157ec6c6d3c3f12ab083ec34256bb50e",
"assets/assets/images/screens_2.png": "61ed5a868c959f413e6d97e72c3ab14d",
"assets/assets/images/short_arrow_left.png": "7f11ed180f9ef0d5c78a59dff6a897e0",
"assets/assets/images/small_mercury.png": "059af3e800a4f26cb20008de5362dfaf",
"assets/assets/images/text_group.png": "3278f031dcd8a4219c784c903545b14b",
"assets/assets/images/venus_mercury.png": "b2fac7ab5623983d96077465d7edd177",
"assets/assets/images/zognest_team.png": "dbc73c161e5fb6954df89feb8e272dad",
"assets/assets/svg/arrow_down.svg": "f264fd66a3d8db112e19c97aa3913b9d",
"assets/assets/svg/arrow_up.svg": "17e6dacac9f7f967829a2f2c65f40a0b",
"assets/assets/svg/discord.svg": "1b32ad92793f5c113cff43a6f33658ec",
"assets/assets/svg/drawer.svg": "600172010273c3114f789740706df58c",
"assets/assets/svg/dribble.svg": "da498bed0e40b9af71e4cfd0040eba7b",
"assets/assets/svg/facebook.svg": "5756f04d36a1c1c942bdee337aff84be",
"assets/assets/svg/figma.svg": "05d29d4e1c4f6bca7f035069b4b36f7d",
"assets/assets/svg/grid_lines.svg": "70ba8b7bea87e0d3404ee0da85d0aae0",
"assets/assets/svg/hamburger.svg": "3f63fba9e8984de05f835ef069faf03f",
"assets/assets/svg/impact_lines.svg": "52d4c5003bf8954179d6fcb337a5b8f1",
"assets/assets/svg/instagram.svg": "dc2ca558d7244a54f806a5b67d875b9e",
"assets/assets/svg/linkedin.svg": "e7ced194386f1a863e606e68e0ef6c12",
"assets/assets/svg/logo.svg": "5fb2bf2d07d6180b6f93586357de0459",
"assets/assets/svg/mail.svg": "866e2a070fff265a5292ce4672b177fe",
"assets/assets/svg/medium-icon.svg": "168cf780be70e0d9106d4b749725b70e",
"assets/assets/svg/medium.svg": "0fee9bfebacb8fa053f727d9bacd6f4c",
"assets/assets/svg/pintrest.svg": "ea4ae8c447a88707ffe24552c0030ec0",
"assets/assets/svg/whatsapp.svg": "bb96dd8bc8cdb66409367ab23ceff80d",
"assets/assets/svg/youtube.svg": "5a79339bab1e7d78024888228f48f561",
"assets/FontManifest.json": "8c6e5e8414e08bf85bc2ae58ba10c2c0",
"assets/fonts/MaterialIcons-Regular.otf": "7e324e4b7c00f474f34b57eef0cf3578",
"assets/fonts/Oswald/Oswald-Variable.ttf": "033f2e7815bfa96db10bbb07ca20fb93",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Black.otf": "41cd4e684cec8b6fa83aaada8bad8873",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Bold.otf": "bf108f8e2fcbda9e4ea2b18ed7799caf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Light.otf": "5d6b13c011fc2e019e5276b4ae744bdf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Medium.otf": "137ee8cda3c7f9c388e62aca25c82744",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Regular.otf": "6720e086a89d34cb9ca424a3ba913082",
"assets/fonts/SFProRounded/SF-Pro-Rounded-SemiBold.otf": "02dc9f029efbbe4cd105420f50202dd9",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Thin.otf": "f8ab0e64878f5c5e3db454b6f89dd0cd",
"assets/NOTICES": "fac0f8e88ce204947dc2a4c592dc0d35",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "a6d5570276f4fb802258237c33076e2a",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "da6b90e08eb5b38ea28f6fc5f547c180",
"/": "da6b90e08eb5b38ea28f6fc5f547c180",
"main.dart.js": "9a08bf20b35b7775cb7b8824b827df17",
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
