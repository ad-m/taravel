"use strict";
var fs = require('fs'),
    path = require('path'),
    gulp = require('gulp'),
    $ = require('gulp-load-plugins')(),
    livereload = require('gulp-livereload'),
    json = JSON.parse(fs.readFileSync('./package.json')),
    browserSync = require('browser-sync'),
    reload = browserSync.stream,
    args = require('yargs').argv;

var config = (function () {
    var appName = json.name;

    var path = {
        bower: './bower_components/',
        assets: './' + appName + '/assets',
        static: './' + appName + '/static'
    };

    return {
        path: path,
        scss: {
            input: path.assets + '/scss/style.scss',
            include: [
                path.bower + '/bootstrap/scss/',
                path.bower + '/font-awesome/scss',
                path.assets + '/scss/',
            ],
            output: path.static + "/css",
            watch: [
                path.assets + '/scss/**.scss'
            ]
        },
        icons: {
            input: [
                path.bower + '/font-awesome/fonts/**.*'
            ],
            output: path.static + "/fonts"
        },
        script: {
            input: [
                path.bower + '/jquery/dist/jquery.js',
                path.bower + '/bootstrap-sass/assets/javascripts/bootstrap/tab.js',
                path.bower + '/bootstrap-sass/assets/javascripts/bootstrap/transition.js',
                path.bower + '/bootstrap-sass/assets/javascripts/bootstrap/dropdown.js',
                path.bower + '/bootstrap-sass/assets/javascripts/bootstrap/tooltip.js',
                path.assets + '/js/*.js'
            ],
            output: path.static + '/js/script.js',
            watch: [
                path.assets + '/js/*.js'
            ]
        }
    };
}());

gulp.task('bower', function () {
    return $.bower(config.path.bower);
});

gulp.task('icons', function () {
    return gulp.src(config.icons.input)
        .pipe(gulp.dest(config.icons.output));
});

gulp.task('config', function () {
    console.log(config);
});

gulp.task('serve', function (){
    browserSync({
        proxy: args.host || 'localhost:8000'
    });
});

gulp.task('js', function () {
    var filename = path.basename(config.script.output);
    var dirname = path.dirname(config.script.output);
    console.log({filename:filename, dirname:dirname})
    return gulp.src(config.script.input)
        .pipe(require('gulp-debug')())
        .pipe($.concat(filename))
        .pipe(require('gulp-debug')())
        .pipe(gulp.dest(dirname))
        .pipe(livereload())
        .pipe($.uglify())
        .pipe($.rename({ extname: '.min.js' }))
        .pipe(require('gulp-debug')())
        .pipe(gulp.dest(dirname))
        .pipe(require('gulp-debug')())
        .pipe(livereload());
});

gulp.task('scss', function () {
   return gulp.src(config.scss.input)
            .pipe(require('gulp-debug')())
            .pipe($.sass({
               style: "expanded",
               includePaths: config.scss.include
            }))
            .pipe(require('gulp-debug')())
            .pipe($.autoprefixer())
            .pipe(require('gulp-debug')())
            .pipe(gulp.dest(config.scss.output))
            .pipe(require('gulp-debug')())
            .pipe(livereload())
            .pipe(require('gulp-debug')())
            .pipe($.rename({ extname: '.min.css' }))
            .pipe(require('gulp-debug')())
            .pipe($.minifyCss())
            .pipe(require('gulp-debug')())
            .pipe(gulp.dest(config.scss.output))
            .pipe(require('gulp-debug')())
            .pipe(livereload());
});

// Rerun the task when a file changes
gulp.task('watch', ['serve'], function () {
    livereload.listen();
    config.scss.watch.forEach(function (path) {
        gulp.watch(path, ['scss']);
    });
    config.script.watch.forEach(function (path) {
        gulp.watch(path, ['js']);
    });
});

gulp.task('default', ['bower', 'icons', 'js', 'scss', 'watch']);
