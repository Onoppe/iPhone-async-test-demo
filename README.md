# Demos an example approach of unit testing iPhone asynchronous web-services.

This demo application tests ``DataApi.m``

## Using

To use copy the Test1 target into your code and follow the convention in Test1AppDelegate.

In your NSURLController add the following to the ``connectionDidFinishLoading:`` method


	#ifdef UNIT_TEST
	[[NSNotificationCenter defaultCenter] postNotificationName:@"unitTestFinished" object:nil];
	#endif


## Etc

Inspiration: Gabriel Handford's [http://github.com/gabriel/gh-unit](http://github.com/gabriel/gh-unit)

# TODO:

This is just a beginning of a full featured unit testing framework.

- make into a static library
- make setup of new tests seamless
- make chaining of tests seamless
- better documentation


# twitter

follow me on twitter: [@robspychala](http://twitter.com/robspychala)