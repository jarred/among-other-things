var gulp          = require('gulp');
var del           = require('del');
var livereload    = require('gulp-livereload');
var sass          = require('gulp-sass');
var concat        = require('gulp-concat');

gulp.task('cleanup', function (cb) {
  del(['assets/css/style.css'], cb);
});


gulp.task('scss', ['cleanup'], function (){
  return gulp.src('assets/_scss/style.scss')
    .pipe(sass())
    .pipe(concat('style.css'))
    .pipe(gulp.dest('assets/css'));
});

gulp.task('watch', function (){
  var server = livereload();
  var reload = function(file) {
    server.changed(file.path);
  };

  gulp.watch('assets/_scss/**/*.scss',  ['scss']);

  gulp.watch(['_site' + '/**/*'])
    .on('change', reload);
});


gulp.task('default', ['scss', 'watch'])