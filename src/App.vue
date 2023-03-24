<template>
  <div>
    <!-- <Ping></Ping> -->
    <Header></Header>
    <router-view></router-view>
    <Footer></Footer>
  </div>
</template>
<script>
import Header from "./components/Header.vue";
import Footer from "./components/Footer.vue";
// import Ping from "./components/Ping.vue";
export default {
  components: {
    Header,
    Footer,
    // Ping,
  },
};
</script>