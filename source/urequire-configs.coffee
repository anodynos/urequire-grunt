# NOT IMPLEMENTED

_ = require 'lodash'
_B = require 'uberscore'

S = if process.platform is 'win32' then '\\' else '/' # OS directory separator
nodeBin       = "node_modules#{S}.bin#{S}"            # run from local node_modules,

class URequireConfigs  

  @defaultOptions =
    projectName   : "projectName#"        # @todo: read pkg.name
    identifiers   : "projectName" # eg, '$' or ['$', 'jQuery'] - acts as `export: root`, `export: bundle` etc
    sourceDir     : "source/code"
    buildDir      : "build"
    sourceSpecDir : "source/spec"
    buildSpecDir  : "build/spec"
    VERSION       : "0.0.0"
    
    #other
    main          : undefined    

  constructor: (options)->
    _.defaults @, options if options
    _.defaults @, @constructor.defaultOptions if options isnt @constructor.defaultOptions

    defaults:    
      path: @sourceDir
      copy: [/./]
      resources: [          
        [ '+inject:VERSION' , ["#{@projectName}.js"], (m)->m.beforeBody = "var VERSION='#{@VERSION}';"]
      ]
      
      main: @main

      clean: true
      template:
        banner: """ 
         /**
          * #{@projectName} - version #{ @VERSION }
          */\n""" # @todo: add date, license etc

    UMD:
      template: 'UMDplain'
      dstPath: "#{@buildDir}/UMD"

    AMD:
      template: 'AMD'
      dstPath: "#{@buildDir}/AMD"
      
    nodejs:
      template: 'nodejs'
      dstPath: "#{@buildDir}/nodejs"      

    dev:
      template:
        name: 'combined'
      dstPath: "#{@buildDir}/combined/#{@projectName}-dev.js"

    min:
      derive: ['dev', '_defaults']
      dstPath: "#{@buildDir}/combined/#{@projectName}-min.js"
      optimize: 'uglify2'
      rjs: preserveLicenseComments: false

    spec:
      derive: []
      path: @sourceSpecDir
      copy: [/./]
      dstPath: @buildSpecDir
      commonCode:
        "var expect = chai.expect; // injected @ `spec: bundle: commonCode`."

      dependencies: exports: bundle: _B.okv, {}
        chai: 'chai'
        @projectName: @identifiers
        specHelpers: 'specHelpers'

    specDev:
      derive: ['spec']
      dstPath: "#{@buildSpecDir}/combined/index-dev.js"
      template: name: 'combined'
