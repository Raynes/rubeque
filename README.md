# Rubeque [![Build Status](https://secure.travis-ci.org/daviddavis/rubeque.png)](http://travis-ci.org/daviddavis/rubeque)

Rubeque is an interactive problem website for learning Ruby.

## Contributing

Anyone interested in contributing should check out
the [Issues](https://github.com/daviddavis/rubeque/issues) page for ideas
on what to work on.

## Setup instructions for running locally

* Download and install [rvm](http://beginrescueend.com/).
* Download and install [mongodb](http://www.mongodb.org/).
* Enter the rubeque directory from the command line and follow the rvm instructions to install ruby 1.9.3
* Start up your mongodb, if you don't have autostart:

        mongod
* Run "bundle install" to install the necessary gems
* For the first time use, you will need to load the problem data. Run "rake db:seed"
* Run `rails server`

## Contributors

* [David Davis](https://github.com/daviddavis) (daviddavis)
* [Kamal Bennoune](https://github.com/kbennoune) (kbennoune)
* [Joe Peck](https://github.com/joepeck) (joepeck)
* [Michael Stalker](https://github.com/mstalker) (mstalker)
* [Joseph Jaber](https://github.com/josephjaber) (josephjaber)

## Acknowledgements

* [SciMed Solutions, Inc](http://www.scimedsolutions.com) for providing the time and resources necessary to make this.
* [4clojure](http://www.4clojure.com) for providing advice and support.
* [envylabs](https://github.com/envylabs) for their Ruby Conf presentation and RubyCop

## License

The source code for rubeque is available under the [MIT License](http://www.opensource.org/licenses/MIT).