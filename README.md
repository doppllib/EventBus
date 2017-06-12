# Doppl Fork

This is a fork of the Eventbus library to provide tests and modifications to support 
iOS development with J2objc using the [Doppl build framework](http://doppl.co/).

## Versions

[2.4.0](https://github.com/doppllib/EventBus)

## Usage

```groovy
dependencies {
    compile 'de.greenrobot:eventbus:2.4.0'
    doppl 'co.doppl.de.greenrobot:eventbus:2.4.0.2'
}
```

## Status

Stable. No known memory issues. Minor test issues related to iOS/Java differences.

## Notes

There was some UI related stuff, which was removed. Error dialog and such.

Tests need to be run in Xcode manually because of main thread/background thread involvement.

## Library Development

See [docs](http://doppl.co/docs/createlibrary.html) for an overview of our setup and repo org for forked library development.

# License

EventBus binaries and source code can be used according to the [Apache License, Version 2.0](LICENSE).

More Open Source by greenrobot
==============================
[__greenrobot-common__](https://github.com/greenrobot/greenrobot-common) is a set of utility classes and hash functions for Android & Java projects.

[__greenDAO__](https://github.com/greenrobot/greenDAO) is an ORM optimized for Android: it maps database tables to Java objects and uses code generation for optimal speed.

[Follow us on Google+](https://plus.google.com/b/114381455741141514652/+GreenrobotDe/posts) to stay up to date.
