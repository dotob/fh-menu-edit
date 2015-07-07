fs = require 'fs'
gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
jade = require 'gulp-jade'
inject = require 'gulp-inject'
mainBowerFiles = require 'main-bower-files'
stylus = require 'gulp-stylus'
util = require 'gulp-util'
ignore = require 'gulp-ignore'
debug = require 'gulp-debug'

# config dirs
coffee_files = ['coffee/**/*.coffee']
jade_files = ['jade/**/*.jade']
stylus_files = ['styles/**/*.styl']
asset_files = ['assets/**']
out_dir = './public'

# only client coffee files
gulp.task 'js', ->
	gulp.src coffee_files
		.pipe sourcemaps.init()
			.pipe coffee()
		.pipe sourcemaps.write() #{includeContent: false, sourceRoot: out_dir} 
		.pipe gulp.dest "#{out_dir}/js"

gulp.task 'jade', ->
	gulp.src jade_files
		.pipe jade({pretty: true})
		.pipe gulp.dest out_dir

gulp.task 'stylus', ->
	gulp.src stylus_files
		.pipe stylus()
		.pipe gulp.dest "#{out_dir}/css"

gulp.task 'assets', ->
	gulp.src asset_files
		.pipe gulp.dest "#{out_dir}/assets"

gulp.task 'inject', ['js', 'stylus'], ->
	gulp.src "#{out_dir}/index.html"
	# bower stuff
	.pipe inject(gulp.src(mainBowerFiles(), { read: false }).pipe(debug({title: 'inject bower:'})), { name: 'bower', relative: true})
	# our own (mostly angular stuff)
	.pipe inject(gulp.src(["#{out_dir}/js/**/*.js","#{out_dir}/css/**/*.css"], { read: false }).pipe(debug({title: 'inject own:'})), { ignorePath: "#{out_dir}/bower", name: 'own', relative: true})
	# where to
	.pipe gulp.dest out_dir

gulp.task 'watch', ->
	gulp.watch coffee_files, ['js']
	gulp.watch jade_files, ['jade', 'inject']
	gulp.watch stylus_files, ['stylus']
	gulp.watch asset_files, ['assets']

gulp.task 'dev', ['js', 'jade', 'stylus', 'assets', 'inject'], ->

# The default task (called when you run `gulp` from cli)
gulp.task 'default', ['dev']