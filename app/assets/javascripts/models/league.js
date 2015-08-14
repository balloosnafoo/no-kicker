NoKicker.Models.League = Backbone.Model.extend({
  urlRoot: "/api/leagues",

  user_team: function () {
    // debugger;
    if (!this._user_team) {
      this._user_team = new NoKicker.Collections.Teams([], { league: this });
    }
    return this._user_team;
  },

  teams: function () {
    if (!this._teams) {
      this._teams = new NoKicker.Collections.Teams([], { league: this });
    }
    return this._teams;
  },

  parse: function (response) {
    if (response.user_team) {
      this.user_team().set(response.user_team, { parse: true });
      delete response.user_team;
    }

    if (response.teams) {
      this.teams().set(response.teams, { parse: true });
      delete response.teams;
    }

    return response;
  }
});
