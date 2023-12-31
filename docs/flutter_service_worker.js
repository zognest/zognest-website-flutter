'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "172073c8f417c4786bd25720738be7bc",
"assets/AssetManifest.bin.json": "198049dea3fdb81f7e6367c3bb00d920",
"assets/AssetManifest.json": "9445d949d319d53af6d39180514b9a13",
"assets/assets/images/about_us_text.png": "d72282daa629bd1aea81d1838c4e7c79",
"assets/assets/images/arrow_right.png": "3a9fb519ad16f50d9e33db417dc94086",
"assets/assets/images/impact_lines.png": "9ef8cf5421af5888230b3bd730ed32f0",
"assets/assets/images/logo.png": "0482e4310f3697228e0586386fc14324",
"assets/assets/images/mercuries.png": "f3188735fec96ab2b4687f93b6627a37",
"assets/assets/images/mercury.png": "8053f840b18bb665df7d49cc8640f28e",
"assets/assets/images/mercury_venus.png": "f18b9b57aa42c5cf6b06fa832e04654a",
"assets/assets/images/mobile_about_us_text.png": "c56c9ee29259f9c9d5b438fe77fef671",
"assets/assets/images/moon.png": "db64bd084cc3fe604783f9e065aaf8bb",
"assets/assets/images/office.png": "a1cfa6303f688e096dbc2b3562492b5c",
"assets/assets/images/our_services_text.png": "4eddfa7b89db22605d5bd9743ca0df8b",
"assets/assets/images/our_space_text.png": "c98fa6b78710a434b3e7ea3a13766de5",
"assets/assets/images/phone_mockup.png": "e3c19af480bca5eaac5ad5610f2c5e8f",
"assets/assets/images/screens.png": "3f0c26176d9eba9885841b378fdcaa68",
"assets/assets/images/short_arrow_left.png": "7f11ed180f9ef0d5c78a59dff6a897e0",
"assets/assets/images/small_mercury.png": "059af3e800a4f26cb20008de5362dfaf",
"assets/assets/images/text_group.png": "3278f031dcd8a4219c784c903545b14b",
"assets/assets/images/venus_mercury.png": "742dbcc0acdf56a10fb01354a8bfacc0",
"assets/assets/images/zognest_team.png": "dbc73c161e5fb6954df89feb8e272dad",
"assets/assets/svg/404.svg": "894342acc1b96f09b5be3185180799ec",
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
"assets/assets/svg/logo.svg": "6b8780a6002e318aea4fdf1bdf83e7b9",
"assets/assets/svg/mail.svg": "866e2a070fff265a5292ce4672b177fe",
"assets/assets/svg/pintrest.svg": "ea4ae8c447a88707ffe24552c0030ec0",
"assets/assets/svg/whatsapp.svg": "bb96dd8bc8cdb66409367ab23ceff80d",
"assets/assets/svg/youtube.svg": "5a79339bab1e7d78024888228f48f561",
"assets/assets/temp/ajmera.png": "002002d12610ffa6261f12bf5bd15ff4",
"assets/assets/temp/mahalaxmi.png": "c6258ad65c4e6d0c79565f434d55f19a",
"assets/assets/temp/sjrc.png": "f23de83a5b64d4323d438144eda1257c",
"assets/assets/temp/texas_chiro.png": "bb4f05d63192202a118c2a09c2827df1",
"assets/assets/temp/tooth.png": "49baff48f19e1a69748052893b49d9be",
"assets/assets/temp/vais.png": "af8fb257431426f4ace1a6672bf63059",
"assets/FontManifest.json": "8c6e5e8414e08bf85bc2ae58ba10c2c0",
"assets/fonts/MaterialIcons-Regular.otf": "5cee66eff16f8a4a1b461c7d7065532a",
"assets/fonts/Oswald/Oswald-Variable.ttf": "033f2e7815bfa96db10bbb07ca20fb93",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Black.otf": "41cd4e684cec8b6fa83aaada8bad8873",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Bold.otf": "bf108f8e2fcbda9e4ea2b18ed7799caf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Light.otf": "5d6b13c011fc2e019e5276b4ae744bdf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Medium.otf": "137ee8cda3c7f9c388e62aca25c82744",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Regular.otf": "6720e086a89d34cb9ca424a3ba913082",
"assets/fonts/SFProRounded/SF-Pro-Rounded-SemiBold.otf": "02dc9f029efbbe4cd105420f50202dd9",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Thin.otf": "f8ab0e64878f5c5e3db454b6f89dd0cd",
"assets/NOTICES": "c330ed73688be8198e251d9410e7b74a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "64edb91684bdb3b879812ba2e48dd487",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "f87e541501c96012c252942b6b75d1ea",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "4124c42a73efa7eb886d3400a1ed7a06",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "59a12ab9d00ae8f8096fffc417b6e84f",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "f7f15612543be6b07b3934cc38f877c5",
"/": "f7f15612543be6b07b3934cc38f877c5",
"main.dart.js": "21bee678203245542161c039e2100ff0",
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
