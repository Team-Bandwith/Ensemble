<template>
  <b-container fluid>
    <div class="section-header">Direct Messages</div>
    <div>
      <span v-for="dm in dms" :key="dm.id">
        <DirectMessage :user="user" :dm="dm"></DirectMessage>
      </span>
    </div>
  </b-container>
</template>

<script>
import { request } from 'graphql-request';

import DirectMessage from './DirectMessage.vue';

export default {
  name: 'direct-message-list',
  props: {
    id: Number,
    user: Object,
  },
  components: {
    DirectMessage,
  },
  data() {
    return {
      dms: {},
    };
  },
  methods: {
    getUserDMs(id) {
      const query = `query {
        getUserDMs(id: ${id}) {
          id,
          id_user_to,
          id_user_from,
          text,
          created_at,
          username,
          url_avatar
        }
      }`;
      request(`${process.env.NODE_ENV === 'development' ? 'http://localhost:8081' : ''}/api`, query)
        .then((res) => {
          const userDMs = {};
          res.getUserDMs.forEach((dm) => {
            if (userDMs[dm.id_user_from]) {
              userDMs[dm.id_user_from].push(dm);
            } else {
              userDMs[dm.id_user_from] = [dm];
            }
          });
          this.dms = Object.values(userDMs)
            .map((dms) => dms[0])
            .sort((a, b) => new Date(b.created_at) - new Date(a.created_at));
        })
        .catch((err) => console.log(err));
    },
  },
  created() {
    this.getUserDMs(this.id);
  },
};
</script>

<style>
.section-header {
  font-size: 25px;
  margin-top: 10px;
  margin-left: 35px;
}
</style>
