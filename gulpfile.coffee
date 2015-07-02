gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'


gulp.task 'default', ->
  gulp.src ['./src/*.coffee']
      .pipe coffee(bare: yes)
      .pipe gulp.dest('lib')
      .on 'error', gutil.log
