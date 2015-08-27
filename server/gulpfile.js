/**
 * Created by UC165867 on 7/6/2015.
 */
var gulp = require('gulp');
var nodemon = require('gulp-nodemon');

gulp.task('default', function() {
    nodemon({
        script: './bin/www' ,
        ext: 'js css html json jade',
        env: { 'NODE_ENV': 'production' }
    })
});


gulp.task('dev', function() {
    nodemon({
        script: './bin/www' ,
        ext: 'js css html json jade',
        env: { 'NODE_ENV': 'development' }
    })
});