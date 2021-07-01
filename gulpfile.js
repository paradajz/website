const gulp          = require('gulp');
const browserSync   = require('browser-sync').create();
const sass          = require('gulp-sass')(require('sass'));
const prefix        = require('gulp-autoprefixer');
const minify        = require('gulp-minifier');
const { task }      = require('gulp');
const imagemin      = require('gulp-imagemin');
const pngquant      = require('imagemin-pngquant');
const sassPaths     = ['_scss/*.scss', '_scss/*/*.scss'];
const jekyllPaths   = ['*.html', '_includes/*.html', '_includes/*/*.html', '_layouts/*.html', '_layouts/*/*.html', '_posts/*', 'js/*.js', 'images/*'];
const imagePath     = 'images/';
const imagePathOpt  = '_site/images';

task('sass', function () {
  return gulp.src(sassPaths)
      .pipe(sass({
        outputStyle: 'expanded',
        // sourceComments: 'map',
        includePaths: ['scss'],
        onError: browserSync.notify('Error in sass')
      }))
      .on('error', sass.logError)
      .pipe(prefix(['last 15 versions', '> 1%', 'ie 8', 'ie 7'], { cascade: true }))
      .pipe(gulp.dest('_site/css'))
      .pipe(browserSync.stream());
});

task('build', function() {
    return require('child_process').spawn('jekyll', ['build'], {stdio: 'inherit'})
        .on('close', browserSync.reload);
});

task('minify', function() {
    return gulp.src('_site/**/*').pipe(minify({
      minify: true,
      minifyHTML: {
        collapseWhitespace: true,
        conservativeCollapse: true,
      },
      minifyJS: {
        sourceMap: true
      },
      minifyCSS: true,
      getKeptComment: function (content, filePath) {
          var m = content.match(/\/\*![\s\S]*?\*\//img);
          return m && m.join('\n') + '\n' || '';
      }
    })).pipe(gulp.dest('_site/deploy'));
});

task('optimizeImg', function() {
  return gulp.src(imagePath + '*', imagePath + '**/*')
      .pipe(imagemin({
        progressive: true,
        use: [pngquant({
        quality: '65-75'
        })]
      }))
      .pipe(gulp.dest(imagePathOpt));
});

task('serve', function() {
    browserSync.init({
        server: {
            baseDir: '_site'
        }
    });

    gulp.watch(sassPaths, gulp.parallel('sass'));
    gulp.watch(jekyllPaths)
    .on('change', gulp.parallel('build'));
});

task('build-all', gulp.parallel('build', 'sass'));
task('default', gulp.series('build-all', 'serve'));
task('prod', gulp.series('build-all', 'minify'));