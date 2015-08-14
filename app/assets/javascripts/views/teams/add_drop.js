NoKicker.Views.TeamAddDrop = Backbone.View.extend({
  template: JST['teams/add_drop'],

  className: "container add-drop-form",

  addPlayerAddDropItem: function (toAdd, player) {
    var appendSelector = toAdd ? ".to-add-table" : ".to-drop-table";
    var playerAddDropItem = new NoKicker.Views.PlayerAddDropItem({
      player: player
    });

    this.addSubview(appendSelector, playerAddDropItem);
  },

  render: function () {
    var renderedContent = this.template({
      team: this.collection
      // addition:
    });

    this.$el.html(renderedContent);
    return this;
  },

  renderAddDropItems: function () {
    this.addPlayerAddDropItem(this.toAddPlayer);
  }
});
