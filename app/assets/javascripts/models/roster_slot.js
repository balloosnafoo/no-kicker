NoKicker.Models.RosterSlot = Backbone.Model.extend({
  urlRoot: '/api/roster_slots',

  player: function () {
    if (!this._player) {
      this._player = new NoKicker.Models.Player();
    }
    return this._player;
  },

  parse: function (response) {
    if (response.player) {
      var attrs = this.player().parse(response.player)
      this.player().set(response.player);
      delete response.player;
    }

    return response;
  }
});
