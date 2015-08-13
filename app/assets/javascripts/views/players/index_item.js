NoKicker.Views.PlayerIndexItem = Backbone.View.extend({
  template: JST['players/index_item'],

  tagName: 'tr',

  className: "player-listing",

  initialize: function () {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      player: this.model
    });

    this.$el.html(renderedContent);
    return this;
  }
});
