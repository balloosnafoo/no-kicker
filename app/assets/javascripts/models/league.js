NoKicker.Models.League = Backbone.Model.extend({
  urlRoot: "/api/leagues",

  user_team: function () {
    if (!this._user_team) {
      this._user_team = new NoKicker.Models.Team();
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
      var attrs = this.user_team().parse(response.user_team);
      this.user_team().set(attrs);
      delete response.user_team;
    }

    if (response.teams) {
      this.teams().set(response.teams, { parse: true });
      delete response.teams;
    }

    return response;
  }
});
