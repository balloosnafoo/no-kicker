NoKicker.Views.RosterSlotTradeIndexItem = Backbone.View.extend({
  template: JST['roster_slots/trade_index_item'],

  tagName: "tr",

  className: "trade-selection-item",

  initialize: function (options) {
    this.team = options.team;
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model.player(),
      roster_slot: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
