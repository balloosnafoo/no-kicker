NoKicker.Views.MatchupIndex = Backbone.View.extend({
  template: JST['matchups/index'],

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({

    });

    this.$el.html(renderedContent);
    return this;
  },

  addMatchup: function (matchup) {

  },

  renderMatchups: function () {

  }
});
