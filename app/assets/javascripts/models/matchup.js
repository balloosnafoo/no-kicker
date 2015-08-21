NoKicker.Models.Matchup = Backbone.Model.extend({
  urlRoot: "/api/matchups",

  team1: function () {
    if (!this._team1) {
      this._team1 = new NoKicker.Models.Team();
    }

    return this._team1;
  },

  team2: function () {
    if (!this._team2) {
      this._team2 = new NoKicker.Models.Team();
    }

    return this._team2;
  },

  parse: function (response) {
    if (response.team_1) {
      this.team1().set(response.team_1, { parse: true });
      delete response.team_1;
    }

    if (response.team_2) {
      this.team2().set(response.team_2, { parse: true });
      delete response.team_2;
    }

    return response;
  }
});
