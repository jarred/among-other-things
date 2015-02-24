var gulp          = require('gulp');
var del           = require('del');
var livereload    = require('gulp-livereload');
var sass          = require('gulp-sass');
var concat        = require('gulp-concat');
var browserify    = require('gulp-browserify');
var uglify        = require('gulp-uglify');

gulp.task('cleanup', function (cb) {
  del(['assets/css/style.css'], cb);
});


gulp.task('scss', ['cleanup'], function (){
  return gulp.src('assets/_scss/style.scss')
    .pipe(sass())
    .pipe(concat('style.css'))
    .pipe(gulp.dest('assets/css'));
});

gulp.task('js', [], function(){
  return gulp.src('assets/_js/main.js')
    .pipe(browserify())
    .pipe(concat('app.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest('assets'))
});

gulp.task('watch', function (){
  var server = livereload();
  var reload = function(file) {
    server.changed(file.path);
  };

  gulp.watch('assets/_scss/**/*.scss',  ['scss']);
  gulp.watch('assets/_js/**/*.js',  ['js']);

  gulp.watch(['_site' + '/**/*'])
    .on('change', reload);
});


gulp.task('default', ['scss', 'js', 'watch'])
