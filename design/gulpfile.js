var gulp = require('gulp'),
    gls = require('gulp-live-server');

var settings = {
  directory: 'public',
  port: 3000
};

gulp.task('livereload', function() {
  var directory = settings.directory;

  var server = gls.static(directory, settings.port);
  server.start();

  gulp.watch([directory + '/**/*.css', directory + '/**/*.js', directory + '/**/*.html'], function (file) {
    server.notify.apply(server, [file]);
  });
});
