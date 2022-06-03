'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "manifest.json": "39bd145e875d193cf3fe10278589fbdd",
"main.dart.js": "e84b22b93abdf83c78c022e81cfc3cf8",
"flutter.js": "0816e65a103ba8ba51b174eeeeb2cb67",
"app.js": "5b5cc543cbd66bffad9a41f6578ef8e8",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/NOTICES": "0919053d8ee25f276dd64eb577c1bdf0",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"icons/android-icon-96x96.png": "e9c6d554b21a63686968861674de9dad",
"icons/android-icon-144x144.png": "b6a841ec325720291af8c173f04df2bb",
"icons/android-icon-72x72.png": "dd451e2fbb8b592a1255d66cab69b1e9",
"icons/apple-icon-180x180.png": "8209c9e847663dacf75b411e44defd6a",
"icons/android-icon-36x36.png": "4771e5a257f75648618513be5efe5f82",
"icons/apple-icon-57x57.png": "006a4f96e60582573c89ccbf10b7d7d7",
"icons/favicon-16x16.png": "e61262790bbe3732b06f58167ccec89a",
"icons/apple-icon-114x114.png": "51465416e158f976a6ade5a1bdfa4fe7",
"icons/ms-icon-150x150.png": "1f4774fb7edebbac1dfdd731e7f6f54c",
"icons/apple-icon-152x152.png": "ff451351b9ff1684b94fdf5f5e9d7e12",
"icons/ms-icon-144x144.png": "a785920b31e3ca8e53bb196f3b572149",
"icons/apple-icon-precomposed.png": "73da9f6805af7865fa97ddb032a30beb",
"icons/android-icon-48x48.png": "df1a7411732ae49aa790e57912294577",
"icons/ms-icon-70x70.png": "3782f8435330c451e94bcc633d63d8bf",
"icons/apple-icon.png": "73da9f6805af7865fa97ddb032a30beb",
"icons/apple-icon-60x60.png": "ba28a70e759f58ac4ddcda1d48705f34",
"icons/apple-icon-120x120.png": "c851b511ca7d6efd500cf0309320ee0f",
"icons/apple-icon-72x72.png": "dd451e2fbb8b592a1255d66cab69b1e9",
"icons/favicon-96x96.png": "00042211555b641784f30bec41f3481e",
"icons/favicon-32x32.png": "ddd0a83e27aa15c7e0c7908c988a3dd9",
"icons/ms-icon-310x310.png": "a5229ff12993a284bb28d26626f97914",
"icons/apple-icon-144x144.png": "b6a841ec325720291af8c173f04df2bb",
"icons/favicon.ico": "0027f7ec15c37b974df45e2446ec2f33",
"icons/apple-icon-76x76.png": "36854126dfc4d0de7b0089c64c39bee7",
"icons/android-icon-192x192.png": "9c42c2e87a779c4cf57479813ee32ece",
"keplr.js": "e1238996601a77dd6cbda7112299664f",
"favicon.png": "f594eaea1f04728f86abef51414ddd6e",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"version.json": "8e018e128268416e1db39f1bea804e50",
"index.html": "5282a0d68e1a5f5e14e4e9d0756743c4",
"/": "5282a0d68e1a5f5e14e4e9d0756743c4",
"cosmjs.js": "705523ecc0a503871b3ab19d7841628c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
