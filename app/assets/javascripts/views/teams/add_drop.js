NoKicker.Views.TeamAddDrop = Backbone.CompositeView.extend({
  template: JST['teams/add_drop'],

  className: "container add-drop-form",

  initialize: function (options) {
    this.toAddPlayer = options.toAddPlayer;
    this.league = options.league;
    this.collection = options.league.user_team().players();

    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.toAddPlayer, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPlayerAddDropItem.bind(this, false));
  },

  addPlayerAddDropItem: function (toAdd, player) {
    // debugger;
    var appendSelector = toAdd ? ".to-add-table" : ".to-drop-table";
    var playerAddDropItem = new NoKicker.Views.PlayerAddDropItem({
      model: player
    });

    this.addSubview(appendSelector, playerAddDropItem);
  },

  render: function () {
    this.$el.html(this.template());
    this.renderAddDropItems();
    return this;
  },

  renderAddDropItems: function () {
    this.addPlayerAddDropItem(true, this.toAddPlayer);
    this.collection.each( function (player) {
      this.addPlayerAddDropItem(false, player)
    }.bind(this));
  }
});
