NoKicker.Views.RosterSlotTradeIndexItem = Backbone.View.extend({
  template: JST['roster_slots/trade_index_item'],

  tagName: "tr",

  className: "trade-selection-item",

  initialize: function (options) {
    if (options.team !== options.user_team){ debugger };
    this.team = options.team;
    this.user_team = options.user_team;
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model.player(),
      roster_slot: this.model,
      team: this.team,
      user_team: this.user_team
    });

    this.$el.html(renderedContent);
    return this;
  }
});
