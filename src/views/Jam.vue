<template>
  <b-container class="jam-page">
    <b-row>
      <b-col cols="8">
        <div class="jammers"><h4>Jam Room</h4></div>
          <div class="jam-instrument">
            <Instrument
              :id="user.id"
              :active="active"
              :users="users"
              v-on:active="activate"
              v-on:deact="deactivate"
            />
          </div>
            <BandMembers
              :users="users"
              :you="user"
              :online="online.filter((usr) => usr.id !== user.id && friends[usr.id])"
            />

      </b-col>
      <b-col cols="4" class="jam-chat">
          <div class="chat"><h4>Chat</h4></div>
          <Chat
          :user="user"
          v-on:active="activate"
          v-on:deact="deactivate"
        />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
/* eslint-disable camelcase */
import Tone from 'tone';
import randomstring from 'randomstring';
import Instrument from '../components/instrument.vue';
import Chat from '../components/chat.vue';
import BandMembers from '../components/band-members.vue';


export default {
  name: 'jam',
  components: {
    Instrument,
    Chat,
    BandMembers,
  },
  data() {
    return {
      users: [],
      active: true,
    };
  },
  props: {
    user: Object,
    online: Array,
    friends: Object,
  },
  watch: {
    user(val) {
      this.$socket.emit('join', { room: this.$route.query.room, user: val });
      Tone.start();
    },
  },
  mounted() {
    if (this.user) {
      this.$socket.emit('join', { room: this.$route.query.room, user: this.user });
      Tone.start();
    }
  },
  beforeRouteEnter(to, from, next) {
    if (to.fullPath === '/jam') {
      next({
        path: '/jam',
        query: { room: randomstring.generate() },
      });
    } else {
      next();
    }
  },
  methods: {
    activate() {
      this.active = true;
    },
    deactivate() {
      this.active = false;
    },
  },
  sockets: {
    updateUsers(currUsers) {
      this.users = currUsers.filter((user) => user.id !== this.user.id);
    },
  },
  beforeRouteLeave(to, from, next) {
    if (to.name !== 'Jam' && window.location.search) {
      this.$socket.emit('leaveRoom', this.$route.query.room);
    }
    next();
  },
};

</script>

<style>
.jam-instrument {
  width: 100%;
}
.jam-height{

}
.jammers,
.chat {
  color: #FFF;
}
.jammers{
  padding: 1em;
}
.jam-band{
  border: 1px solid #6d8657;
}
</style>
