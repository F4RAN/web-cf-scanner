<template>
  <div class="main">
    <div dir="rtl">
      <div class="d-flex justify-content-center p-5">
        <ve-progress
          :progress="
            (getProgress() /
              (numIPs != 'custom' ? numIPs : parseInt(customIPs))) *
            100
          "
          :legend-formatter="
            ({ currentValue }) =>
              `${results.length}/${
                numIPs != 'custom' ? numIPs : parseInt(customIPs)
              }`
          "
          lineMode="in"
        />
      </div>
      <div class="d-flex justify-content-center">
        <p
          v-if="workingOn"
          :class="
            workingOn.status == 'waiting'
              ? 'text-warning'
              : workingOn.status == 'accepted'
              ? 'text-success'
              : 'text-danger'
          "
        >
          {{ workingOn.ip }} <i class="fa fa-circle-notch fa-spin"></i>
        </p>
      </div>
      <div v-if="results.length > 1 && results[0].speed != -1" class="p-5 pb-0">
        <label for="">بهترین:</label>
        <div class="d-flex justify-content-center">
          <div
            style="cursor: pointer"
            v-clipboard:copy="results[0].ip"
            v-clipboard:success="onCopy"
          >
            <span class="mr-2 pr-2 pl-2"
              ><svg
                fill="#f8f7f7"
                height="16px"
                width="16px"
                version="1.1"
                id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                viewBox="0 0 64 64"
                enable-background="new 0 0 64 64"
                xml:space="preserve"
                stroke="#f8f7f7"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  <g id="Text-files">
                    <path
                      d="M53.9791489,9.1429005H50.010849c-0.0826988,0-0.1562004,0.0283995-0.2331009,0.0469999V5.0228 C49.7777481,2.253,47.4731483,0,44.6398468,0h-34.422596C7.3839517,0,5.0793519,2.253,5.0793519,5.0228v46.8432999 c0,2.7697983,2.3045998,5.0228004,5.1378999,5.0228004h6.0367002v2.2678986C16.253952,61.8274002,18.4702511,64,21.1954517,64 h32.783699c2.7252007,0,4.9414978-2.1725998,4.9414978-4.8432007V13.9861002 C58.9206467,11.3155003,56.7043495,9.1429005,53.9791489,9.1429005z M7.1110516,51.8661003V5.0228 c0-1.6487999,1.3938999-2.9909999,3.1062002-2.9909999h34.422596c1.7123032,0,3.1062012,1.3422,3.1062012,2.9909999v46.8432999 c0,1.6487999-1.393898,2.9911003-3.1062012,2.9911003h-34.422596C8.5049515,54.8572006,7.1110516,53.5149002,7.1110516,51.8661003z M56.8888474,59.1567993c0,1.550602-1.3055,2.8115005-2.9096985,2.8115005h-32.783699 c-1.6042004,0-2.9097996-1.2608986-2.9097996-2.8115005v-2.2678986h26.3541946 c2.8333015,0,5.1379013-2.2530022,5.1379013-5.0228004V11.1275997c0.0769005,0.0186005,0.1504021,0.0469999,0.2331009,0.0469999 h3.9682999c1.6041985,0,2.9096985,1.2609005,2.9096985,2.8115005V59.1567993z"
                    ></path>
                    <path
                      d="M38.6031494,13.2063999H16.253952c-0.5615005,0-1.0159006,0.4542999-1.0159006,1.0158005 c0,0.5615997,0.4544001,1.0158997,1.0159006,1.0158997h22.3491974c0.5615005,0,1.0158997-0.4542999,1.0158997-1.0158997 C39.6190491,13.6606998,39.16465,13.2063999,38.6031494,13.2063999z"
                    ></path>
                    <path
                      d="M38.6031494,21.3334007H16.253952c-0.5615005,0-1.0159006,0.4542999-1.0159006,1.0157986 c0,0.5615005,0.4544001,1.0159016,1.0159006,1.0159016h22.3491974c0.5615005,0,1.0158997-0.454401,1.0158997-1.0159016 C39.6190491,21.7877007,39.16465,21.3334007,38.6031494,21.3334007z"
                    ></path>
                    <path
                      d="M38.6031494,29.4603004H16.253952c-0.5615005,0-1.0159006,0.4543991-1.0159006,1.0158997 s0.4544001,1.0158997,1.0159006,1.0158997h22.3491974c0.5615005,0,1.0158997-0.4543991,1.0158997-1.0158997 S39.16465,29.4603004,38.6031494,29.4603004z"
                    ></path>
                    <path
                      d="M28.4444485,37.5872993H16.253952c-0.5615005,0-1.0159006,0.4543991-1.0159006,1.0158997 s0.4544001,1.0158997,1.0159006,1.0158997h12.1904964c0.5615025,0,1.0158005-0.4543991,1.0158005-1.0158997 S29.0059509,37.5872993,28.4444485,37.5872993z"
                    ></path>
                  </g>
                </g></svg
            ></span>
            {{ results[0].ip }}
          </div>
        </div>
      </div>
      <div class="p-5 pt-4 pb-3">
        <label> تعداد آی پی:</label>
        <div class="row mt-3" style="text-align: center">
          <div
            @click="
              num != 'custom' ? (numIPs = num) : (numIPs = 'custom');
              customInput = true;
            "
            class="col-1 bg-light text-dark m-1 p-1 pt-2"
            :style="
              numIPs == num
                ? {
                    background: '#007bff!important',
                    color: 'white!important',
                  }
                : {}
            "
            dir="ltr"
            style="border-radius: 10px; min-width: 100px"
            v-for="num in ['custom', 10, 50]"
            :key="num"
          >
            {{ num != "custom" ? num : "مقدار دلخواه" + " " }}
          </div>
        </div>
        <hr v-if="numIPs == 'custom'" />
        <div v-if="numIPs == 'custom'" class="col-md-5 col-sm-12">
          <label for="">مقدار دلخواه:</label>
          <input v-model="customIPs" class="form-control mt-2" />
        </div>
      </div>

      <div class="d-flex justify-content-center">
        <button
          @click="!started ? startScan() : (stop = true)"
          class="circle-button"
        >
          {{ !started ? "شروع" : "توقف" }}
        </button>
      </div>
    </div>

    <hr />
    <h3 dir="rtl" class="p-2" id="results">نتایج:</h3>

    <div class="p-2">
      <div style="min-height: 90vh; overflow-y: scroll; overflow-x: hidden">
        <div
          class="row p-2 pt-3"
          style="border-bottom: 1px gray solid; cursor: pointer"
          v-for="result in results"
          :key="result.ip"
        >
          <small v-if="result.download != -1">
            <svg
              fill="#94fffd"
              width="16px"
              height="16px"
              viewBox="0 0 1024 1024"
              xmlns="http://www.w3.org/2000/svg"
              stroke="#94fffd"
            >
              <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
              <g
                id="SVGRepo_tracerCarrier"
                stroke-linecap="round"
                stroke-linejoin="round"
              ></g>
              <g id="SVGRepo_iconCarrier">
                <path
                  d="M512 666.5L367.2 521.7l36.2-36.2 83 83V256h51.2v312.5l83-83 36.2 36.2L512 666.5zm-204.8 50.3V768h409.6v-51.2H307.2z"
                ></path>
              </g></svg
            >{{ (result.download / 100).toFixed(2) }}
          </small>
          <small v-else
            ><svg
              fill="#f0f0f0"
              height="16px"
              width="16px"
              version="1.1"
              id="Capa_1"
              xmlns="http://www.w3.org/2000/svg"
              xmlns:xlink="http://www.w3.org/1999/xlink"
              viewBox="-29.7 -29.7 356.40 356.40"
              xml:space="preserve"
              stroke="#f0f0f0"
              transform="rotate(0)"
            >
              <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
              <g
                id="SVGRepo_tracerCarrier"
                stroke-linecap="round"
                stroke-linejoin="round"
              ></g>
              <g id="SVGRepo_iconCarrier">
                <path
                  d="M250.929,276.619h-17.463v-31.301c0-31.668-17.379-60.777-48.936-81.967c-3.924-2.635-6.363-8.324-6.363-14.852 s2.439-12.215,6.365-14.852c31.555-21.188,48.934-50.297,48.936-81.965V20.381h17.461c5.627,0,10.189-4.562,10.189-10.191 C261.118,4.561,256.556,0,250.929,0H46.071c-5.627,0-10.19,4.561-10.19,10.189c0,5.629,4.563,10.191,10.19,10.191h17.463v31.303 c0,31.668,17.377,60.777,48.936,81.965c3.924,2.637,6.363,8.324,6.363,14.852c0,6.529-2.439,12.217-6.365,14.854 c-31.557,21.188-48.934,50.297-48.934,81.965v31.301H46.071c-5.627,0-10.19,4.563-10.19,10.191c0,5.629,4.563,10.19,10.19,10.19 h204.857c5.627,0,10.189-4.56,10.189-10.19C261.118,281.182,256.556,276.619,250.929,276.619z M83.915,245.318 c0-33.275,25.006-55.035,39.914-65.043c9.633-6.467,15.385-18.346,15.385-31.775c0-13.428-5.752-25.307-15.385-31.773 c-14.908-10.008-39.914-31.768-39.914-65.043V20.381h129.17l-0.002,31.303c0,33.275-25.006,55.035-39.912,65.041 c-9.635,6.469-15.387,18.348-15.387,31.775c0,13.43,5.752,25.307,15.385,31.775c14.908,10.008,39.914,31.768,39.916,65.043v31.301 H83.915V245.318z"
                ></path>
              </g></svg
          ></small>
          <small class="col-3" :style="{ color: result.color }"
            ><svg
              fill="#e8e8e8"
              width="16px"
              height="16px"
              viewBox="0 0 24 24"
              xmlns="http://www.w3.org/2000/svg"
              stroke="#e8e8e8"
            >
              <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
              <g
                id="SVGRepo_tracerCarrier"
                stroke-linecap="round"
                stroke-linejoin="round"
              ></g>
              <g id="SVGRepo_iconCarrier">
                <g id="Wave_Pulse_1" data-name="Wave Pulse 1">
                  <path
                    d="M8.974,18h0a1.446,1.446,0,0,1-1.259-.972L5.872,12.883c-.115-.26-.262-.378-.349-.378H2.562a.5.5,0,1,1,0-1H5.523a1.444,1.444,0,0,1,1.263.972l1.839,4.145c.116.261.258.378.349.378h0c.088,0,.229-.113.344-.368L13.7,6.956A1.423,1.423,0,0,1,14.958,6h0a1.449,1.449,0,0,1,1.26.975l1.839,4.151c.11.249.259.379.349.379h3.028a.5.5,0,0,1,0,1H18.41a1.444,1.444,0,0,1-1.263-.975L15.308,7.379c-.116-.261-.259-.378-.35-.379h0c-.088,0-.229.114-.344.368l-4.385,9.676A1.437,1.437,0,0,1,8.974,18Z"
                  ></path>
                </g>
              </g></svg
            >{{ result.time != -1 ? result.time + " ms" : "Error" }}</small
          ><span
            class="col-5 d-flex justify-content-center"
            v-clipboard:copy="result.ip"
            v-clipboard:success="onCopy"
            >{{ result.ip }}</span
          >
          <div class="col-4 d-flex justify-content-end">
            <span
              v-clipboard:copy="result.ip"
              v-clipboard:success="onCopy"
              class="mr-5 ml-5"
              style="margin-right: 10px"
              ><svg
                style=""
                fill="#f8f7f7"
                height="16px"
                width="16px"
                version="1.1"
                id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                viewBox="0 0 64 64"
                enable-background="new 0 0 64 64"
                xml:space="preserve"
                stroke="#f8f7f7"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  <g id="Text-files">
                    <path
                      d="M53.9791489,9.1429005H50.010849c-0.0826988,0-0.1562004,0.0283995-0.2331009,0.0469999V5.0228 C49.7777481,2.253,47.4731483,0,44.6398468,0h-34.422596C7.3839517,0,5.0793519,2.253,5.0793519,5.0228v46.8432999 c0,2.7697983,2.3045998,5.0228004,5.1378999,5.0228004h6.0367002v2.2678986C16.253952,61.8274002,18.4702511,64,21.1954517,64 h32.783699c2.7252007,0,4.9414978-2.1725998,4.9414978-4.8432007V13.9861002 C58.9206467,11.3155003,56.7043495,9.1429005,53.9791489,9.1429005z M7.1110516,51.8661003V5.0228 c0-1.6487999,1.3938999-2.9909999,3.1062002-2.9909999h34.422596c1.7123032,0,3.1062012,1.3422,3.1062012,2.9909999v46.8432999 c0,1.6487999-1.393898,2.9911003-3.1062012,2.9911003h-34.422596C8.5049515,54.8572006,7.1110516,53.5149002,7.1110516,51.8661003z M56.8888474,59.1567993c0,1.550602-1.3055,2.8115005-2.9096985,2.8115005h-32.783699 c-1.6042004,0-2.9097996-1.2608986-2.9097996-2.8115005v-2.2678986h26.3541946 c2.8333015,0,5.1379013-2.2530022,5.1379013-5.0228004V11.1275997c0.0769005,0.0186005,0.1504021,0.0469999,0.2331009,0.0469999 h3.9682999c1.6041985,0,2.9096985,1.2609005,2.9096985,2.8115005V59.1567993z"
                    ></path>
                    <path
                      d="M38.6031494,13.2063999H16.253952c-0.5615005,0-1.0159006,0.4542999-1.0159006,1.0158005 c0,0.5615997,0.4544001,1.0158997,1.0159006,1.0158997h22.3491974c0.5615005,0,1.0158997-0.4542999,1.0158997-1.0158997 C39.6190491,13.6606998,39.16465,13.2063999,38.6031494,13.2063999z"
                    ></path>
                    <path
                      d="M38.6031494,21.3334007H16.253952c-0.5615005,0-1.0159006,0.4542999-1.0159006,1.0157986 c0,0.5615005,0.4544001,1.0159016,1.0159006,1.0159016h22.3491974c0.5615005,0,1.0158997-0.454401,1.0158997-1.0159016 C39.6190491,21.7877007,39.16465,21.3334007,38.6031494,21.3334007z"
                    ></path>
                    <path
                      d="M38.6031494,29.4603004H16.253952c-0.5615005,0-1.0159006,0.4543991-1.0159006,1.0158997 s0.4544001,1.0158997,1.0159006,1.0158997h22.3491974c0.5615005,0,1.0158997-0.4543991,1.0158997-1.0158997 S39.16465,29.4603004,38.6031494,29.4603004z"
                    ></path>
                    <path
                      d="M28.4444485,37.5872993H16.253952c-0.5615005,0-1.0159006,0.4543991-1.0159006,1.0158997 s0.4544001,1.0158997,1.0159006,1.0158997h12.1904964c0.5615025,0,1.0158005-0.4543991,1.0158005-1.0158997 S29.0059509,37.5872993,28.4444485,37.5872993z"
                    ></path>
                  </g>
                </g></svg
            ></span>
            <span class="" style="margin-right: 10px">
              <svg
                v-if="result.location == 'Worldwide'"
                version="1.1"
                id="_x32_"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                width="16px"
                height="16px"
                viewBox="0 0 512 512"
                xml:space="preserve"
                fill="#000000"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  <g>
                    <path
                      fill="white"
                      class="st0"
                      d="M463.203,105.688c-3.047-4.25-6.234-8.406-9.609-12.484C406.641,36.313,335.531,0,256,0 C176.484,0,105.359,36.313,58.406,93.203c-3.375,4.078-6.563,8.234-9.594,12.484C18.078,147.922,0,199.844,0,256 c0,56.313,18.156,108.484,49.031,150.719c3.125,4.328,6.406,8.563,9.844,12.656C105.844,475.922,176.719,512,256,512 c79.688,0,150.813-36.406,197.75-93.438c3.453-4.078,6.734-8.313,9.781-12.641C494.078,363.766,512,312,512,256 C512,199.844,493.922,147.922,463.203,105.688z M471.688,247.969H385.75c-0.625-32.563-5.031-63.438-12.5-91.219 c21.156-7.219,40.594-16.359,57.781-27.063C455.328,163.156,470.047,203.938,471.688,247.969z M263.984,41.906 c37.375,5.188,70.438,46.109,89.297,104.281c-27.469,7.828-57.594,12.406-89.297,13.094V41.906z M247.984,41.906v117.375 c-31.703-0.688-61.828-5.266-89.297-13.094C177.547,88.016,210.609,47.094,247.984,41.906z M247.984,175.266v72.703H142.219 c0.625-30.766,4.891-60.094,11.984-86.516C183.094,169.75,214.703,174.594,247.984,175.266z M247.984,263.969v72.703 c-33.234,0.797-64.828,5.734-93.703,14.094c-7.141-26.484-11.422-55.922-12.063-86.797H247.984z M247.984,352.656v117.375 c-37.297-5.172-70.313-45.938-89.188-103.938C186.625,358.031,216.734,353.453,247.984,352.656z M263.984,470.031V352.625 c31.703,0.563,61.859,5.094,89.359,12.875C334.5,423.813,301.406,464.844,263.984,470.031z M263.984,336.625v-72.656H369.75 c-0.625,30.625-4.859,59.859-11.891,86.188C328.938,341.938,297.281,337.188,263.984,336.625z M263.984,247.969v-72.703 c33.281-0.672,64.891-5.5,93.797-13.797c7.078,26.406,11.344,55.75,11.969,86.5H263.984z M421.281,117.203 c-15.656,9.547-33.344,17.703-52.563,24.266c-13.219-40.938-33.266-74-57.406-94.219 C354.906,58.797,393.156,83.609,421.281,117.203z M200.656,47.25c-24.141,20.234-44.188,53.281-57.406,94.203 c-19.188-6.563-36.891-14.703-52.531-24.25C118.844,83.625,157.063,58.813,200.656,47.25z M80.969,129.688 c17.188,10.703,36.609,19.828,57.75,27.063c-7.469,27.781-11.875,58.656-12.5,91.219H40.313 C41.953,203.938,56.688,163.156,80.969,129.688z M40.313,263.969h85.906c0.625,32.688,5.063,63.688,12.594,91.563 c-21.094,7.25-40.469,16.359-57.609,27.031C56.75,348.984,41.938,308.109,40.313,263.969z M91.125,395.203 c15.875-9.703,33.484-17.797,52.281-24.297c13.219,40.781,33.25,73.703,57.344,93.844 C157.344,453.25,119.219,428.594,91.125,395.203z M311.219,464.75c24.25-20.25,44.359-53.438,57.578-94.547 c19.281,6.547,37.047,14.719,52.734,24.281C393.313,428.234,354.938,453.156,311.219,464.75z M431.359,381.922 c-17.266-10.734-36.781-19.859-58.016-27.063c7.406-27.703,11.781-58.453,12.406-90.891h85.938 C470.078,307.859,455.5,348.438,431.359,381.922z"
                    ></path>
                  </g>
                </g>
              </svg>
              <svg
                v-else
                height="16px"
                width="16px"
                version="1.1"
                id="Layer_1"
                xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                viewBox="0 0 512.001 512.001"
                xml:space="preserve"
                fill="#000000"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  <path
                    style="fill: #ffffff"
                    d="M474.446,321.512L474.446,321.512l-0.004-26.206v-0.002l-0.001-4.213l-0.004-25.574l-0.008-48.824 l-0.004-26.204l-0.007-40.984c0-2.995-0.406-5.931-1.16-8.75c-0.404-1.517-0.915-2.997-1.521-4.435 c-2.477-5.877-6.574-11.017-11.925-14.74c-0.784-0.545-1.584-1.071-2.419-1.553l-22.874-13.202l-21.414-12.358l-17.239-9.949 l-65.926-38.046l-25.717-14.844l-19.288-11.132l-11.953-6.899c-10.534-6.078-23.509-6.076-34.04,0.007l-11.872,6.857l-19.288,11.14 l-25.717,14.854v-0.001l-50.39,29.105l-15.527,8.967l-28.89,16.686L65.85,113.578l-11.284,6.517 c-0.811,0.468-1.59,0.979-2.353,1.506c-3.273,2.268-6.073,5.068-8.333,8.235c-1.517,2.129-2.781,4.424-3.773,6.843 c-1.655,4.031-2.558,8.399-2.557,12.899v1.503l0,0l0.006,39.407v1.932l0,0l0.004,24.273l0.005,31.087l0,0l0.007,41.338l0,0v1.313 v4.011v0.849v0.002v0.013v0.005l0.004,26.2v0.001v1.863l0.001,12.617l0.001,8.488l0,0l0.002,18.009v0.006l0,0 c0,0.773,0.033,1.539,0.084,2.304c0.016,0.225,0.042,0.445,0.061,0.669c0.048,0.548,0.105,1.096,0.18,1.638 c0.033,0.236,0.071,0.471,0.108,0.706c0.087,0.545,0.184,1.086,0.298,1.626c0.042,0.201,0.084,0.403,0.13,0.603 c0.14,0.615,0.298,1.222,0.471,1.826c0.033,0.112,0.061,0.227,0.095,0.339c0.908,3.042,2.239,5.93,3.94,8.588 c0,0.001,0.001,0.002,0.001,0.002l0.001,0.002c1.172,1.832,2.517,3.551,4.025,5.137c0.051,0.052,0.099,0.106,0.148,0.158 c0.061,0.065,0.131,0.121,0.193,0.183l0,0c0.653,0.667,1.328,1.315,2.039,1.931c0.125,0.108,0.254,0.213,0.382,0.321 c0.786,0.661,1.594,1.298,2.445,1.89c0.784,0.545,1.584,1.07,2.419,1.553l22.552,13.015l21.414,12.36l11.528,6.653l0,0l6.032,3.482 l91.644,52.89l19.288,11.132l11.953,6.899c10.534,6.078,23.509,6.076,34.04-0.007l11.872-6.857l19.288-11.14l25.717-14.853 l55.554-32.086l10.363-5.985l26.36-15.225l21.408-12.365l13.813-7.978c0.811-0.468,1.59-0.979,2.353-1.506 c0.851-0.588,1.659-1.226,2.446-1.884c0.129-0.107,0.258-0.212,0.386-0.323c0.779-0.671,1.526-1.374,2.236-2.108 c0.047-0.047,0.09-0.096,0.136-0.146c3.725-3.891,6.476-8.609,8.02-13.765c0.031-0.107,0.06-0.216,0.09-0.323 c0.176-0.611,0.336-1.228,0.48-1.85c0.046-0.2,0.088-0.401,0.13-0.603c0.113-0.54,0.213-1.085,0.3-1.634 c0.039-0.236,0.076-0.473,0.11-0.711c0.076-0.544,0.131-1.092,0.181-1.643c0.02-0.225,0.047-0.447,0.061-0.674 c0.052-0.767,0.084-1.537,0.084-2.313l0,0v-0.006L474.446,321.512z"
                  ></path>
                  <path
                    style="fill: #ed1f34"
                    d="M474.429,226.166H285.834V21.017l-0.901-0.52l-11.953-6.899c-10.534-6.078-23.509-6.076-34.04,0.007 l-11.872,6.857l-0.901,0.521v205.184H37.563l0.004,21.614l0,0l0.006,38.052h188.596v205.151l0.901,0.52l11.953,6.899 c10.534,6.078,23.509,6.076,34.04-0.007l11.872-6.857l0.901-0.52V285.834h188.606l-0.004-20.317L474.429,226.166z"
                  ></path>
                  <path
                    d="M483.459,149.505c0-3.711-0.493-7.439-1.465-11.08c-0.506-1.899-1.155-3.789-1.925-5.615 c-3.179-7.544-8.398-13.991-15.094-18.652c-1.118-0.778-2.089-1.4-3.062-1.961L277.5,5.767C270.963,1.994,263.516,0,255.967,0 c-7.555,0-15.005,1.996-21.549,5.776L50.044,112.265c-0.95,0.549-1.896,1.152-2.978,1.902c-4.086,2.831-7.635,6.335-10.547,10.421 c-1.912,2.683-3.519,5.597-4.775,8.658c-2.147,5.23-3.234,10.724-3.234,16.336l0.036,212.914c0,0.921,0.034,1.876,0.105,2.919 c0.016,0.237,0.039,0.475,0.061,0.711l0.013,0.136c0.061,0.696,0.134,1.39,0.228,2.071c0.036,0.27,0.078,0.536,0.137,0.898 c0.11,0.688,0.234,1.373,0.38,2.075c0.053,0.254,0.107,0.508,0.163,0.745c0.177,0.78,0.377,1.553,0.603,2.333 c0.04,0.148,0.082,0.295,0.117,0.411c1.127,3.773,2.771,7.38,4.891,10.723c0.051,0.083,0.104,0.166,0.157,0.247 c1.47,2.286,3.164,4.441,5.013,6.383c0.052,0.057,0.184,0.198,0.239,0.252c0.113,0.117,0.229,0.23,0.351,0.345 c0.846,0.857,1.647,1.611,2.417,2.277c0.136,0.121,0.276,0.236,0.415,0.352l0.096,0.08c1.093,0.919,2.105,1.699,3.096,2.388 c1.096,0.763,2.096,1.403,3.064,1.963l184.411,106.428c6.539,3.773,13.985,5.768,21.534,5.768l0,0 c7.554,0,15.005-1.998,21.547-5.776l184.372-106.488c0.945-0.546,1.891-1.15,2.986-1.907c0.991-0.687,2.004-1.466,3.156-2.43 c0.148-0.122,0.294-0.244,0.422-0.354c0.989-0.851,1.942-1.75,2.846-2.685l0.159-0.171c4.695-4.904,8.205-10.929,10.135-17.375 c0.046-0.151,0.088-0.301,0.13-0.457c0.223-0.775,0.427-1.553,0.605-2.336c0.058-0.253,0.112-0.508,0.166-0.767 c0.145-0.687,0.271-1.378,0.388-2.112c0.046-0.282,0.09-0.565,0.131-0.863c0.094-0.69,0.168-1.384,0.228-2.071l0.016-0.157 c0.023-0.227,0.045-0.454,0.061-0.709c0.071-1.043,0.105-1.999,0.105-2.929L483.459,149.505z M454.649,129.003 c3.881,2.7,6.908,6.445,8.757,10.832c0.448,1.062,0.825,2.157,1.116,3.252c0.565,2.121,0.854,4.28,0.854,6.418l0.011,67.62H294.876 V36.673l157.994,91.184C453.393,128.159,453.958,128.523,454.649,129.003z M48.473,140.11c0.729-1.781,1.662-3.472,2.769-5.025 c1.696-2.378,3.755-4.415,6.119-6.053c0.668-0.463,1.216-0.815,1.725-1.109l158.041-91.28v180.481H46.604l-0.011-67.549 C46.592,146.336,47.224,143.151,48.473,140.11z M57.358,382.999c-0.538-0.375-1.126-0.829-1.787-1.385l-0.292-0.243 c-0.461-0.399-0.95-0.863-1.53-1.455c-0.07-0.071-0.142-0.141-0.215-0.211c0-0.001-0.001-0.001-0.002-0.002 c-1.084-1.138-2.065-2.386-2.916-3.709c-0.014-0.024-0.029-0.046-0.043-0.07c-1.257-1.966-2.231-4.087-2.89-6.296l-0.074-0.262 c-0.127-0.44-0.242-0.882-0.348-1.347l-0.092-0.426c-0.082-0.397-0.156-0.796-0.221-1.209c0-0.004-0.019-0.121-0.02-0.124 l-0.06-0.387c-0.054-0.397-0.094-0.797-0.13-1.209l-0.047-0.475c-0.039-0.561-0.064-1.125-0.064-1.701l-0.011-67.612h170.511 v180.449L59.133,384.141C58.603,383.836,58.039,383.473,57.358,382.999z M465.351,364.089l-0.051,0.529 c-0.035,0.404-0.076,0.806-0.129,1.192l-0.084,0.534c-0.064,0.401-0.136,0.799-0.218,1.191l-0.096,0.447 c-0.105,0.458-0.223,0.911-0.36,1.385l-0.058,0.21c-1.128,3.765-3.164,7.26-5.907,10.125l-0.083,0.09 c-0.512,0.529-1.064,1.05-1.656,1.559l-0.272,0.227c-0.67,0.561-1.257,1.015-1.788,1.382c-0.671,0.465-1.22,0.817-1.731,1.113 l-158.039,91.28V294.875h89.616c4.993,0,9.041-4.047,9.041-9.041s-4.048-9.041-9.041-9.041h-98.657 c-4.993,0-9.041,4.047-9.041,9.041v199.966l-8.253,4.767c-3.796,2.192-8.119,3.351-12.502,3.351c-4.381,0-8.701-1.159-12.496-3.348 l-8.331-4.808V285.834c0-4.994-4.048-9.041-9.041-9.041H46.614l-0.006-41.583h179.562c4.993,0,9.041-4.047,9.041-9.041V26.2 l8.252-4.765c3.796-2.193,8.12-3.351,12.505-3.351c4.381,0,8.701,1.157,12.495,3.347l8.33,4.808v199.929 c0,4.994,4.048,9.041,9.041,9.041h179.556l0.007,41.583h-35.413c-4.993,0-9.041,4.047-9.041,9.041s4.048,9.041,9.041,9.041h35.416 l0.011,67.548C465.411,362.993,465.386,363.561,465.351,364.089z"
                  ></path>
                </g>
              </svg>
            </span>

            <span
              v-if="hasProtocol"
              class=""
              @click="refactorConfig(result.ip)"
            >
              <svg
                width="20"
                height="20"
                fill="#04b441"
                viewBox="0 0 32 32"
                xmlns="http://www.w3.org/2000/svg"
                stroke="#04b441"
              >
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g
                  id="SVGRepo_tracerCarrier"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                ></g>
                <g id="SVGRepo_iconCarrier">
                  <path
                    d="M27.1 14.313V5.396L24.158 8.34c-2.33-2.325-5.033-3.503-8.11-3.503C9.902 4.837 4.901 9.847 4.899 16c.001 6.152 5.003 11.158 11.15 11.16 4.276 0 9.369-2.227 10.836-8.478l.028-.122h-3.23l-.022.068c-1.078 3.242-4.138 5.421-7.613 5.421a8 8 0 0 1-5.691-2.359A7.993 7.993 0 0 1 8 16.001c0-4.438 3.611-8.049 8.05-8.049 2.069 0 3.638.58 5.924 2.573l-3.792 3.789H27.1z"
                  ></path>
                </g>
              </svg>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { cfIPv4 } from "../../public/ips.js";
export default {
  data() {
    return {
      cfIPv4,
      numIPs: 10,
      started: false,
      stop: false,
      ended: false,
      workingOn: "",
      customIPs: 10000,
      downloadSize: "1048576",
      results: [],
      customInput: false,
      sortedResult: [],
      testNo: 0,
      numberOfWorkingIPs: 0,
      validIPs: [],
      maxIP: 10,
      config: "",
      hasProtocol: false,
    };
  },

  methods: {
    refactorConfig(ip) {
      let decoded = this.config.decoded;
      let decoded_obj = JSON.parse(decoded);
      decoded_obj.add = ip;
      console.log(decoded_obj);
      decoded = JSON.stringify(decoded_obj);
      let encode_again = btoa(decoded);
      console.log(encode_again);
      this.$copyText(
        this.config.protocol + encode_again,
        undefined,
        (error, event) => {
          if (error) {
            alert("Can not copy");
            console.log(error);
          } else {
            alert(
              `${this.config.protocol.split("//")[0]} link copied to clipboard`
            );
            console.log(event);
          }
        }
      );
    },
    getProgress() {
      if (!this.customInput) {
        if (this.results.length >= this.customIPs) {
          return this.customIPs;
        } else {
          return this.results.length;
        }
      } else {
        if (this.results.length >= this.numIPs) {
          return this.numIPs;
        } else {
          return this.results.length;
        }
      }
    },
    onCopy() {
      alert("copied to clipboard");
    },

    async startScan() {
      this.started = true;
      this.numberOfWorkingIPs = 0;
      this.validIPs = [];
      this.results = [];
      this.maxIP = !this.customInput ? this.numIPs : this.customIPs;
      var cidr;

      for (var cdnLocation in cfIPv4) {
        if (this.maxIP == 0 || this.numberOfWorkingIPs < this.maxIP) {
          let ips = [];
          for (cidr of cfIPv4[cdnLocation]) {
            if (this.stop) {
              this.stop = true;
              this.started = false;
              break;
            }
            ips = ips.concat(this.cidrToIpArray(cidr));
          }
          this.testIPs(this.randomizeElements(ips), cdnLocation);
        }
      }
      this.results.sort((a, b) => a.speed - b.speed);
      this.started = false;
    },
    async testIPs(ipList, cdnLocation) {
      const timeout = 2500;

      for (const ip of ipList) {
        if (this.stop || this.validIPs.length >= this.maxIP) {
          this.stop = false;
          this.started = false;
          break;
        }

        this.testNo++;
        var testResult = 0;
        const url = `http://${ip}/cdn-cgi/trace`;
        const startTime = performance.now();
        const controller = new AbortController();
        for (const ch of ["", "|", "/", "-", "\\"]) {
          let timeoutId = setTimeout(() => {
            controller.abort();
          }, timeout);
          if (ch) {
            this.workingOn = { ip, status: "waiting" };
            if (ch == "\\") {
              this.workingOn = { ip, status: "accepted" };
            }
          } else {
            this.workingOn = { ip, status: "refused" };
          }
          try {
            await fetch(url, {
              signal: controller.signal,
            });

            testResult++;
          } catch (error) {
            break;
          }
          clearTimeout(timeoutId);
        }

        const duration = performance.now() - startTime;

        if (testResult === 5) {
          this.numberOfWorkingIPs++;

          this.results.push({
            ip: ip,
            location: cdnLocation,
            time: Math.floor(duration / 5),
            download: -1,
          });
          this.measureDownloadRate(10, ip, this.results.length - 1);
        }

        if (this.maxIP > 0 && this.numberOfWorkingIPs >= this.maxIP) {
          break;
        }
      }
    },
    makeTraceRequest(ip) {
      return new Promise((resolve, reject) => {
        const xhr = new XMLHttpRequest();
        xhr.open("GET", `http://${ip}/cdn-cgi/trace`);
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
    measureDownloadRate(numRequests, ip, index) {
      let totalSize = 0;
      let startTime = Date.now();
      const requests = [];
      for (let i = 0; i < numRequests; i++) {
        requests.push(this.makeTraceRequest(ip));
      }
      Promise.all(requests)
        .then((responses) => {
          const endTime = Date.now();
          for (const response of responses) {
            totalSize += response.responseText.length;
          }
          const timeElapsed = endTime - startTime;
          const downloadRate = (totalSize / timeElapsed) * 1000; // Download rate in bytes/second
          this.results[index].download = downloadRate;
          const sortedArr = this.results.sort(
            (a, b) => b.download - a.download
          );
          this.results = sortedArr;
        })
        .catch((error) => {
          console.error(`Error measuring download rate: ${error.message}`);
        });
    },
    cidrToIpArray(cidr) {
      const parts = cidr.split("/");
      const ip = parts[0];
      const mask = parseInt(parts[1], 10);
      const ipParts = ip.split(".");
      const start =
        ((parseInt(ipParts[0], 10) << 24) |
          (parseInt(ipParts[1], 10) << 16) |
          (parseInt(ipParts[2], 10) << 8) |
          parseInt(ipParts[3], 10)) >>>
        0; // convert to unsigned int
      const end = (start | (0xffffffff >>> mask)) >>> 0; // convert to unsigned int

      const ips = [];
      for (let i = start; i <= end; i++) {
        const a = (i >> 24) & 0xff;
        const b = (i >> 16) & 0xff;
        const c = (i >> 8) & 0xff;
        const d = i & 0xff;
        ips.push(`${a}.${b}.${c}.${d}`);
      }
      return ips;
    },

    randomizeElements(arr) {
      return [...arr].sort((el1, el2) => {
        return el2.location === "London"
          ? 0.75 - Math.random()
          : 0.5 - Math.random();
      });
    },
  },
  mounted() {
    console.log(this.cfIPv4);
    if (this.$route.query.config) {
      let protocol = this.$route.query.config.split("//")[0] + "//";
      let encoded = this.$route.query.config.split("//")[1];
      let decoded = atob(encoded);
      this.config = {
        protocol,
        decoded,
        encoded,
      };
      this.hasProtocol = true;
    }
  },
};
</script>
<style scoped>
@import url("https://cdn.jsdelivr.net/gh/rastikerdar/vazirmatn@v33.003/Vazirmatn-font-face.css");
.main {
  font-family: Vazirmatn, sans-serif;
  background: #314864 !important;
  min-height: 100vh;
  color: white;
}
.circle-button {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100px;
  height: 100px;
  border-radius: 50%;
  border: 2px solid #ccc;
  background: linear-gradient(to bottom, #1e90ff, #0080ff);
  box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
  color: #fff;
  font-size: 24px;
  font-weight: bold;
  text-transform: uppercase;
}

.circle-button:hover {
  cursor: pointer;
  background: linear-gradient(to bottom, #0080ff, #1e90ff);
}
</style>
