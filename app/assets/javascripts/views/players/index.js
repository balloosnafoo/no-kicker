NoKicker.Views.PlayerIndex = Backbone.CompositeView.extend({
  template: JST['players/index'],

  className: "container players-index",

  events: {
    "keyup .search-bar": "filterPlayers",
    "click .position-filter-option": "filterPosition"
  },

  initialize: function (options) {
    this.league = options.league;
    this.searchTerm = "";

    this.listenTo(this.collection, "add", this.addPlayer);
    this.listenTo(this.collection, "sync remove", this.render);
  },

  addPlayer: function (player) {
    var playerView = new NoKicker.Views.PlayerIndexItem({
      model: player,
      league: this.league
    });

    this.addSubview('.players-table', playerView);
  },

  render: function () {
    this.$el.html(this.template({
      searchTerm: this.searchTerm,
      players: this.collection
    }));
    this.renderPlayers();
    return this;
  },

  renderPlayers: function () {
    if (this.searchedPlayers) {
      searchedCollection = new NoKicker.Collections.Players(this.searchedPlayers);
      searchedCollection.each(this.addPlayer.bind(this));
    } else {
      this.collection.each(this.addPlayer.bind(this));
    }
  },

  filterPlayers: function (event) {
    this.searchTerm = $(event.currentTarget).val().toLowerCase();
    this.searchedPlayers = [];
    this.searchedPlayers = this.collection.filter( function(player) {
        var nameFragment = new RegExp(this.searchTerm);
        return nameFragment.test(player.get('lname').toLowerCase());
    }.bind(this));
    this.render();

    // This allows the focus to go automatically to the end of the search bar
    this.$(".search-bar").focus();
    var tmpStr = this.$(".search-bar").val();
    this.$(".search-bar").val('');
    this.$(".search-bar").val(tmpStr);
  },

  filterPosition: function (event) {
    event.preventDefault();
    var position = $(event.currentTarget).text();
    this.searchedPlayers = [];
    this.searchedPlayers = this.collection.filter( function(player) {
        if ( position === "Flex" ) {
          return ["RB", "WR", "TE"].indexOf(player.get('position')) !== -1;
        } else {
          return position === player.get('position');
        }
    }.bind(this));
    this.render();
  }
});
