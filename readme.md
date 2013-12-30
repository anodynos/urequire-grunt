# urequire-grunt v0.0.0

The early beginings of a uRequire-based, reusable & configurable template build system.

## NOT IMPLEMENTED - version 0.0.0 (just the idea)

It generalizes what [uRequire](http://urequire.org) does to [uBerscore](https://github.com/anodynos/uBerscore/blob/master/Gruntfile.coffee) or [backbone-orm](https://github.com/vidigami/backbone-orm/pull/8#issuecomment-31297449), as a generic-pick-and-override-what-you-like-ready-for-multiple-builds-config-with-standard-commands.

With a minimum 5-10 line configuration, you can have an out-of-the-box, ready-to-work grunt & urequire based build system that:

* builds modules for UMD, AMD, nodejs, combined.js (almond/rjs), etc

* minifies, root exports & performs dependency injections

* 90% of a grunt's *usual suspects* functionality like watching, cleaning, inject:VERSION, banners, copying etc are here (through uRequire or grunt plugins).

* Creation of specs headers & specRunners (HTML included) based on mocha & chai and phantomjs

* Reads you package.json & bower.json and it creates all RequireJS boilerplate (paths, shims etc), among others.

* You can always customize / subclass (i.e derive) any task(s)

@examples TERRIBLY UNSTABLE, but the idea is here :-)

```
$ grunt AMD test_AMD min test_min   # does the obvious

$ grunt watch:dev                   # watches the 'dev' build

$ grunt watch:dev_test
  or
$ grunt watch:test_dev              # watches & runs ALL tests after each successfull rebuild.

$ grunt watch:dev_test_phantom      # watches & runs the mocha (phantomjs) tests

$ grunt watch:dev_test_node         # watches & runs the nodejs tests

```

devDependencies: { grunt: '0.4.1', urequire: '>=0.6.10' }

The `'urequire:XXX'` tasks in summary do some or all of those
 * derive (inherit) from 'someTask' (and/or '_defaults')
 * have a `path` as a source
 * filter `filez` within the `path`
 * save everything at `dstPath`
 * converts all modules to UMD/AMD or `#{@projectName}-min.js`
 * copies all other (non-module) files at `dstPath`
 * export a global `window._B` with a `noConflict()`
 * uglifies combined file with some `uglify2` settings
 * injects deps in modules
 * injects strings inside code bodies
 * add banners etc
 * manipulate modules:
   * remove some matched code 'skeletons'
   * replace some deps in arrays, `require`s etc
   * remove some code and a dependency from a specific file.

# What you'll need

All you need is love and

```coffee
{
    projectName   : "myAwesomeLib"        # @default: package.json#name
    identifiers   : "myAwesomeLibID"      # eg, '$' or ['$', 'jQuery'] - acts as `export: root`, `export: bundle` etc
    sourceDir     : "source/code"
    buildDir      : "build"
    sourceSpecDir : "source/spec"
    buildSpecDir  : "build/spec"
}

```

Why would you settle for more than `this` ?

# License

The MIT License

Copyright (c) 2012 Agelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.