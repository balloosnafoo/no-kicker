NoKicker.Models.Team = Backbone.Model.extend({
  urlRoot: "/api/teams",

  players: function () {
    if (!this._players) {
      this._players = new NoKicker.Collections.Players([], { team: this });
    }
    return this._players;
  },

  roster_slots: function () {
    if (!this._roster_slots) {
      this._roster_slots = new NoKicker.Collections.RosterSlots([], { team: this });
    }
    return this._roster_slots;
  },

  parse: function (response) {
    if (response.players) {
      this.players().set(response.players, { parse: true });
      delete response.players;
    }

    if (response.roster_slots) {
      debugger;
      this.roster_slots().set(response.roster_slots, { parse: true });
      delete response.roster_slots;
    }

    return response;
  }
});

// For use in partially filled leagues, where rows should still exist
NoKicker.Models.nullTeam = new NoKicker.Models.Team({
  name: ""
})
