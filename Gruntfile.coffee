module.exports = (grunt) ->
  grunt.initConfig

    coffee:
      compile:
        options:
          bare: true
          # sourceMap: true
        files:
          'js/gallerize.js': 'js/gallerize.coffee'
          'js/app.js': 'js/app.coffee'

    coffeelint:
      plugin: ['js/*.coffee']

    watch:
      files: ['js/*.coffee']
      tasks: ['default']


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['coffeelint', 'coffee']
  # grunt.registerTask 'watch', ['default', 'watch']
  return
