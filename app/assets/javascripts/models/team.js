NoKicker.Models.Team = Backbone.Model.extend({
  urlRoot: "/api/teams",

  players: function () {
    if (!this._players) {
      this._players = new NoKicker.Collections.Players([], { team: this });
    }
    return this._players;
  },

  parse: function (response) {
    if (response.players) {
      this.players().set(response.players, { parse: true });
      delete response.user_team;
    }

    return response;
  }
});

NoKicker.Models.nullTeam = new NoKicker.Models.Team({
  name: ""
})
