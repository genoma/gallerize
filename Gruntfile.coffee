module.exports = (grunt) ->
  grunt.initConfig

    coffee:
      compile:
        options:
          bare: true
          sourceMap: true
        files:
          'js/gallerize.js': 'js/gallerize.coffee'
          'js/app.js': 'js/app.coffee'

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      plugin: ['js/*.coffee']

    watch:
      files: ['js/*.coffee']
      tasks: ['default']

    browserSync:
      bsFiles:
        src : ['css/gallerize.css', 'js/gallerize.coffee']
        options:
          watchTask: true
          server:
            baseDir: "./"


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-browser-sync'

  grunt.registerTask 'watchme', ['browserSync', 'watch']
  grunt.registerTask 'default', ['coffeelint', 'coffee']
  return
