NoKicker.Views.TeamAddDrop = Backbone.CompositeView.extend({
  template: JST['teams/add_drop'],

  className: "container add-drop-form",

  events: {
    "submit form": "makeRequest"
  },

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
    this.stopListening(this.league.user_team(), "all", this.setPlayerCollection);

    this.collection = this.league.user_team().players();
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addPlayerAddDropItem.bind(this, false));
    this.render();
  },

  addPlayerAddDropItem: function (toAdd, player) {
    var playerAddDropItem = new NoKicker.Views.PlayerAddDropItem({
      model: player
    });

    this.addSubview('.add-drop-table', playerAddDropItem);
  },

  render: function () {
    this.$el.html(this.template());
    this.renderAddDropItems();
    return this;
  },

  renderAddDropItems: function () {
    this.addPlayerAddDropItem(true, this.toAddPlayer);
    this.$('.add-drop-table')
        .append("<tr><td colspan='13'><h3>Dropped Player</h3></td></tr>");
    this.collection && this.collection.each( function (player) {
      this.addPlayerAddDropItem(false, player);
    }.bind(this));
  },

  // There are some buggy things going on here.
  makeRequest: function (event) {
    event.preventDefault();
    // Drop request must be made first to pass validation checks
    var toDropId = $(event.currentTarget).serializeJSON().to_drop_id
    var toDropPlayer = this.collection.get(toDropId);
    toDropPlayer.contract().destroy();
    toDropPlayer.contract().clear();

    // Then add request can be made
    this.toAddPlayer.contract().set({
      player_id: this.toAddPlayer.id,
      league_id: this.league.id,
      user_player: true
    });
    this.toAddPlayer.contract().save({}, {
      success: function () {
        this.collection.add(this.toAddPlayer)
      }.bind(this),
      error: function () { debugger; }.bind(this)
    });

    // Redirect doesn't need to wait for success; it can go straight home
    Backbone.history.navigate(
      "leagues/" + this.league.id + "/teams/" + this.league.user_team().id,
      { trigger: true }
    );
  }
});
