NoKicker.Views.MatchupIndex = Backbone.CompositeView.extend({
  template: JST['matchups/index'],

  className: "container-fluid",

  initialize: function (options) {
    this.league = options.league;
    this.week = options.week;
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      league: this.league,
      week: this.week
    });

    this.$el.html(renderedContent);
    this.renderMatchups();
    return this;
  },

  addMatchup: function (matchup, onLeft) {
    var matchupView = new NoKicker.Views.MatchupIndexItem({
      model: matchup,
      league: this.league
    });
    var insertionPoint = onLeft ? ".left-hand-matchups" : ".right-hand-matchups";
    this.addSubview(insertionPoint, matchupView);
  },

  renderMatchups: function () {
    for (var i = 0; i < this.collection.length; i++) {
      var onLeft = this.collection.length / i <= 2 ? true : false;
      this.addMatchup(this.collection.models[i], onLeft);
    }
  }
});
