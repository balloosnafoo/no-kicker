NoKicker.Views.TeamAddDrop = Backbone.CompositeView.extend({
  template: JST['teams/add_drop'],

  className: "container add-drop-form",

  initialize: function (options) {
    this.toAddPlayer = options.toAddPlayer;
    this.league = options.league;
    if (options.league.user_team()){
      this.collection = options.league.user_team().players();
    }

    this.listenTo(this.toAddPlayer, "sync", this.render);
    this.listenTo(this.league.user_team(), "all", this.setPlayerCollection);
  },

  setPlayerCollection: function () {
    this.collection = this.league.user_team().players();
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPlayerAddDropItem.bind(this, false));
  },

  addPlayerAddDropItem: function (toAdd, player) {
    // var appendSelector = toAdd ? ".to-add-table" : ".to-drop-table";
    var appendSelector = toAdd ? ".to-add-rows" : ".to-drop-rows";
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
    this.collection && this.collection.each( function (player) {
      this.addPlayerAddDropItem(false, player);
    }.bind(this));
  }
});
