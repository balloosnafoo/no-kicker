NoKicker.Views.LeagueAllIndex = Backbone.CompositeView.extend({
  template: JST['leagues/all_index'],

  className: "container all-leagues-index",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, "add", this.addLeague);
  },

  addLeague: function (league) {
    var leagueView = new NoKicker.Views.LeagueAllIndexItem({
      model: league
    });

    this.addSubview('.leagues-table', leagueView);
  },

  render: function () {
    var renderedContent = this.template({
      leagues: this.collection
    });

    this.$el.html(renderedContent);
    this.renderTeams();

    return this;
  },

  renderTeams: function () {
    this.collection.each(this.addLeague.bind(this));
  }
});
