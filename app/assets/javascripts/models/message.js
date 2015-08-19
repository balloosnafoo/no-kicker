NoKicker.Models.Message = Backbone.Model.extend({
  urlRoot: "/api/messages",

  comments: function () {
    if (!this._comments) {
      this._comments = new NoKicker.Collections.Comments([], { message: this });
    }

    return this._comments
  },

  parse: function (response) {
    if (response.comments) {
      this.comments().set(response.comments, { parse: true });
      delete response.comments;
    }

    return response;
  }
})
