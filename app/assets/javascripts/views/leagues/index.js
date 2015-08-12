NoKicker.Views.LeagueIndex = Backbone.CompositeView.extend({
  template: JST['leagues/index'],

  className: "container",

  events: {
    "click #new-league-button": "new"
  },

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      leagues: this.collection
    });

    this.$el.html(renderedContent);
    return this;
  },

  new: function (event) {
    event.preventDefault();
    Backbone.history.navigate("leagues/new", { trigger: true });
  }
});
