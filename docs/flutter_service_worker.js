'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "9e890a99c4d8963b84ada0faa8f21389",
"assets/AssetManifest.bin.json": "f20100fed296cf762c1d39d81bdb8f2d",
"assets/AssetManifest.json": "6f1eeabade9b362d56250d015a09fad1",
"assets/assets/images/about_us_text.png": "d72282daa629bd1aea81d1838c4e7c79",
"assets/assets/images/arrow_right.png": "3a9fb519ad16f50d9e33db417dc94086",
"assets/assets/images/logo.png": "0482e4310f3697228e0586386fc14324",
"assets/assets/images/mercuries.png": "f3188735fec96ab2b4687f93b6627a37",
"assets/assets/images/mercury.png": "e937ebdfca3243279aeb4389526d17aa",
"assets/assets/images/mercury_venus.png": "f18b9b57aa42c5cf6b06fa832e04654a",
"assets/assets/images/mobile_about_us_text.png": "c56c9ee29259f9c9d5b438fe77fef671",
"assets/assets/images/moon.png": "db64bd084cc3fe604783f9e065aaf8bb",
"assets/assets/images/office.png": "a1cfa6303f688e096dbc2b3562492b5c",
"assets/assets/images/our_services_text.png": "4eddfa7b89db22605d5bd9743ca0df8b",
"assets/assets/images/our_space_text.png": "c98fa6b78710a434b3e7ea3a13766de5",
"assets/assets/images/phone_hand.png": "687d9988163c5770e9bf9cae60e9ef42",
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
"assets/assets/svg/impact_lines.svg": "1deb6b75ee75fdff64901be2c7cba571",
"assets/assets/svg/instagram.svg": "dc2ca558d7244a54f806a5b67d875b9e",
"assets/assets/svg/linkedin.svg": "e7ced194386f1a863e606e68e0ef6c12",
"assets/assets/svg/logo.svg": "6b8780a6002e318aea4fdf1bdf83e7b9",
"assets/assets/svg/mail.svg": "866e2a070fff265a5292ce4672b177fe",
"assets/assets/svg/pintrest.svg": "ea4ae8c447a88707ffe24552c0030ec0",
"assets/assets/svg/whatsapp.svg": "bb96dd8bc8cdb66409367ab23ceff80d",
"assets/assets/svg/youtube.svg": "5a79339bab1e7d78024888228f48f561",
"assets/assets/temp/ajmera.png": "002002d12610ffa6261f12bf5bd15ff4",
"assets/assets/temp/blog_image.png": "93597c7a8f599b0854095887dc15e069",
"assets/assets/temp/client_feedback_1.png": "80451d4e5d8fb0c18060eb9bc915c3d6",
"assets/assets/temp/client_feedback_2.png": "0c6dcfac4a9146b37ee3d23064833c4f",
"assets/assets/temp/client_image.png": "f076590ad9107bc10387ba677bef8be9",
"assets/assets/temp/cuckoo.png": "6d5565e1cdda69152dd230b8e435d07f",
"assets/assets/temp/drop.png": "da320d6e1937d5b106a85de9fbe97a61",
"assets/assets/temp/event_cover.png": "959c09dc2317bbd67503258c7228f708",
"assets/assets/temp/event_image.png": "b494e814ae2a55f8cd14966a32872655",
"assets/assets/temp/figma.png": "8afdaa5c722952c42cf9fb0d31d9a8c3",
"assets/assets/temp/illustrator.png": "5ade6c2f3cd77fefda4f234565e75f41",
"assets/assets/temp/mahalaxmi.png": "c6258ad65c4e6d0c79565f434d55f19a",
"assets/assets/temp/my_pocket.png": "c0168b4f6e5e4eb8ace7a8be08ec1f32",
"assets/assets/temp/photoshop.png": "8e6320d77aa410dc6b64eb1ba5b62c1a",
"assets/assets/temp/project_icon.png": "593a46be3345c75c96fe419fae5ff055",
"assets/assets/temp/purchasable_service_image.png": "677973f09e0d2591acaefcb433ec5180",
"assets/assets/temp/salt.png": "d842001afee92d1cb61f3feddb040a81",
"assets/assets/temp/service_background.png": "4495ce5f58a13e8ae446fbd1f41805b3",
"assets/assets/temp/sjrc.png": "f23de83a5b64d4323d438144eda1257c",
"assets/assets/temp/sketch.png": "367b2f3ee0f1babf1f6efaf7d19029ce",
"assets/assets/temp/store_loop.png": "edb336a45e2ed525a92bc27480dcbd8a",
"assets/assets/temp/texas_chiro.png": "bb4f05d63192202a118c2a09c2827df1",
"assets/assets/temp/tooth.png": "49baff48f19e1a69748052893b49d9be",
"assets/assets/temp/vais.png": "af8fb257431426f4ace1a6672bf63059",
"assets/assets/temp/xd.png": "d3ae4e8f5353ce37195914c12187a657",
"assets/assets/temp/zeplin.png": "05697a1604252bb5a5609d5784eb7889",
"assets/FontManifest.json": "8c6e5e8414e08bf85bc2ae58ba10c2c0",
"assets/fonts/MaterialIcons-Regular.otf": "3842e84434faad907fb7f3ba02f181b4",
"assets/fonts/Oswald/Oswald-Variable.ttf": "033f2e7815bfa96db10bbb07ca20fb93",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Black.otf": "41cd4e684cec8b6fa83aaada8bad8873",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Bold.otf": "bf108f8e2fcbda9e4ea2b18ed7799caf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Light.otf": "5d6b13c011fc2e019e5276b4ae744bdf",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Medium.otf": "137ee8cda3c7f9c388e62aca25c82744",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Regular.otf": "6720e086a89d34cb9ca424a3ba913082",
"assets/fonts/SFProRounded/SF-Pro-Rounded-SemiBold.otf": "02dc9f029efbbe4cd105420f50202dd9",
"assets/fonts/SFProRounded/SF-Pro-Rounded-Thin.otf": "f8ab0e64878f5c5e3db454b6f89dd0cd",
"assets/NOTICES": "58c638c760e7423c63d2e08c15ec76b6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
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
"index.html": "e72c282e54428634b099ecac9e985538",
"/": "e72c282e54428634b099ecac9e985538",
"main.dart.js": "a5fa922cf52a2c1942aa8f94526e3551",
"manifest.json": "6311effed2b766c79b409f7224328a24",
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
