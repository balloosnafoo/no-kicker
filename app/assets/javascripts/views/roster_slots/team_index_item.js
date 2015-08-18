NoKicker.Views.RosterSlotTeamIndexItem = Backbone.View.extend({
  template: JST['roster_slots/team_index_item'],

  tagName: "tr",

  className: "player-row",

  render: function () {
    var renderedContent = this.template({
      player: this.model.player(),
      roster_slot: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
