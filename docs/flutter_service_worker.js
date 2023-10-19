'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "1f0adf8c5ad6a9f23357d61e1af6bb17",
"assets/AssetManifest.json": "776341c6f7f3376199c1f096e62da387",
"assets/assets/images/arrow_right.png": "8cfaf667494fb29a2c77989afe1cf839",
"assets/assets/images/mercuries.png": "f3188735fec96ab2b4687f93b6627a37",
"assets/assets/images/mercury.png": "e937ebdfca3243279aeb4389526d17aa",
"assets/assets/images/mercury_venus.png": "f18b9b57aa42c5cf6b06fa832e04654a",
"assets/assets/images/office.png": "a1cfa6303f688e096dbc2b3562492b5c",
"assets/assets/images/phone_hand.png": "687d9988163c5770e9bf9cae60e9ef42",
"assets/assets/images/screens.png": "3f0c26176d9eba9885841b378fdcaa68",
"assets/assets/svg/arrow_down.svg": "f264fd66a3d8db112e19c97aa3913b9d",
"assets/assets/svg/arrow_up.svg": "17e6dacac9f7f967829a2f2c65f40a0b",
"assets/assets/svg/discord.svg": "1b32ad92793f5c113cff43a6f33658ec",
"assets/assets/svg/dribble.svg": "da498bed0e40b9af71e4cfd0040eba7b",
"assets/assets/svg/facebook.svg": "5756f04d36a1c1c942bdee337aff84be",
"assets/assets/svg/figma.svg": "05d29d4e1c4f6bca7f035069b4b36f7d",
"assets/assets/svg/grid_lines.svg": "70ba8b7bea87e0d3404ee0da85d0aae0",
"assets/assets/svg/impact_lines.svg": "e124a0c10585056e9365d18a74fcfcb3",
"assets/assets/svg/instagram.svg": "dc2ca558d7244a54f806a5b67d875b9e",
"assets/assets/svg/linkedin.svg": "e7ced194386f1a863e606e68e0ef6c12",
"assets/assets/svg/logo.svg": "af7746168c008466d502637b69082b6d",
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
"assets/assets/temp/figma.png": "8afdaa5c722952c42cf9fb0d31d9a8c3",
"assets/assets/temp/illustrator.png": "5ade6c2f3cd77fefda4f234565e75f41",
"assets/assets/temp/mahalaxmi.png": "c6258ad65c4e6d0c79565f434d55f19a",
"assets/assets/temp/my_pocket.png": "c0168b4f6e5e4eb8ace7a8be08ec1f32",
"assets/assets/temp/photoshop.png": "8e6320d77aa410dc6b64eb1ba5b62c1a",
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
"assets/NOTICES": "ae3db2a16349776e91d0bbbe4972030b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/packages/youtube_player_iframe/assets/player.html": "dc7a0426386dc6fd0e4187079900aea8",
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
"index.html": "af95468ff8da69f40f8d22a6c9001f63",
"/": "af95468ff8da69f40f8d22a6c9001f63",
"main.dart.js": "6dd4e23de29506b0420a81562e88631f",
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
