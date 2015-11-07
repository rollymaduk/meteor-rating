Package.describe({
  name: 'rollypolly:meteor-rating',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'A document rating package for meteor',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/rollymaduk/meteor-rating',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.use('jquery');
  api.use('coffeescript');
  api.use('reactive-var');
  api.use('templating','client');
  api.use('barbatus:stars-rating');
  api.use('digilord:sugarjs');
  api.use('aldeed:simple-schema');
  api.addFiles(['client/ui/common/rate_control.html'
          ,'client/ui/common/rp_rating_modal.html'
          ,'client/ui/common/rp_rating_modal.coffee'
          ,'client/ui/create/rating.html'
          ,'client/ui/create/rating.coffee'
          ,'client/ui/create/rating_detail.coffee'
          ,'client/ui/create/rating_detail.html'
      ,'client/rating.coffee'
      ,'client/ui/view/rating.html'
      ,'client/ui/view/rating.coffee'
  ],'client');
  api.addFiles('server/rating.coffee','server');
  api.addFiles('common/model.coffee');
  api.export('Rp_Rating');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('rollypolly:meteor-rating');
});
