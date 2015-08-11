NoKicker.Views.LeagueNew = Backbone.View.extend({
  template: JST['leagues/new'],

  tagName: "div",

  className: "container",

  events: {
    "submit form": "create"
  },

  render: function () {
    var renderedContent = this.template({
      league: this.model
    });

    this.$el.html(renderedContent);
    return this;
  },

  create: function (event) {
    event.preventDefault();
    var leagueData = $(event.currentTarget).serializeJSON().league;
    this.model.set(leagueData);
    this.model.save({}, {
      success: function () {
        this.collection.add(this.model, { merge: true });
        Backbone.history.navigate(
          "leagues/" + this.model.id, 
          { trigger: true });
      }.bind(this)
    });
  }
});
