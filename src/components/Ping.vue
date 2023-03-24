<template>
  <div>
    <h1>Download Rate: {{ downloadRate.toFixed(2) }} bytes/second</h1>
    <button @click="measureDownloadRate(10)">Measure Download Rate</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      downloadRate: 0,
    };
  },
  methods: {
    makeTraceRequest() {
      return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "http://104.18.234.49/cdn-cgi/trace");
        xhr.onload = () => {
          if (xhr.status >= 200 && xhr.status < 300) {
            const responseText = xhr.responseText;
            const time = Date.now();
            resolve({ responseText, time });
          } else {
            reject(new Error(`Failed to load trace: ${xhr.statusText}`));
          }
        };
        xhr.onerror = () => {
          reject(new Error("Network error occurred while loading trace."));
        };
        xhr.send();
      });
    },
    measureDownloadRate(numRequests) {
      let totalSize = 0;
      let startTime = Date.now();
      const requests = [];
      for (let i = 0; i < numRequests; i++) {
        requests.push(this.makeTraceRequest());
      }
      Promise.all(requests)
        .then((responses) => {
          const endTime = Date.now();
          for (const response of responses) {
            totalSize += response.responseText.length;
          }
          const timeElapsed = endTime - startTime;
          const downloadRate = (totalSize / timeElapsed) * 1000; // Download rate in bytes/second
          this.downloadRate = downloadRate;
        })
        .catch((error) => {
          console.error(`Error measuring download rate: ${error.message}`);
        });
    },
  },
};
</script>
