NoKicker.Views.RosterSlotTeamIndexItem = Backbone.View.extend({
  template: JST['roster_slots/team_index_item'],

  tagName: "tr",

  className: "player-row",

  events: {
    "click .cut-player": "cutPlayer"
  },

  initialize: function (options) {
    this.team = options.team;
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model.player(),
      roster_slot: this.model,
      team: this.team,
      stats: this.model.player().get("stats")
    });

    this.$el.html(renderedContent);
    return this;
  },

  cutPlayer: function (event) {
    event.preventDefault();
    debugger;
    this.model.player().contract().destroy();
    this.model.player().contract().clear();
    this.model.player().clear();
    this.render();
  }
});
