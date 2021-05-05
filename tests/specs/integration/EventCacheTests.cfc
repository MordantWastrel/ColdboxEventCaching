/*******************************************************************************
 *	Integration Test as BDD (CF10+ or Railo 4.1 Plus)
 *
 *	Extends the integration class: coldbox.system.testing.BaseTestCase
 *
 *	so you can test your ColdBox application headlessly. The 'appMapping' points by default to
 *	the '/root' mapping created in the test folder Application.cfc.  Please note that this
 *	Application.cfc must mimic the real one in your root, including ORM settings if needed.
 *
 *	The 'execute()' method is used to execute a ColdBox event, with the following arguments
 *	* event : the name of the event
 *	* private : if the event is private or not
 *	* prePostExempt : if the event needs to be exempt of pre post interceptors
 *	* eventArguments : The struct of args to pass to the event
 *	* renderResults : Render back the results of the event
 *******************************************************************************/
component
	extends   ="coldbox.system.testing.BaseTestCase"
	appMapping="/root"
{

	/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll() {
		super.beforeAll();
		// do your own stuff here
			this.unloadColdbox = true;
	}

	function afterAll() {
		// do your own stuff here
		super.afterAll();
	}

	/*********************************** BDD SUITES ***********************************/

	function run() {
		describe( "Coldbox Template Cache Tests", function() {
			beforeEach( function( currentSpec ) {
				// Setup as a new ColdBox request, VERY IMPORTANT. ELSE EVERYTHING LOOKS LIKE THE SAME REQUEST.
				setup();
			} );

			it( "Can make the same request twice and get a cached response the second time", () => {
				getRequestContext().setValue( 'someInput', 2);
				var event    = get( '/CacheTest');
				var response = event.getPrivateValue( "response" );
				var data = response.getData();
				
				var cached = response.getCachedResponse();
			
				debug( cached );
				debug( data );
				
				var timeStamp = data.timeStamp;
				
				expect( cached ).toBeFalse( 'Response was not cached' );

				// sleep for 2 seconds so the timestamp would be different on the second request if it weren't cached
				sleep( 2000 );
				setup();

				// use the same input so we should trigger a cached response
				getRequestContext().setValue( 'someInput', 2);
				
				var eventAgain = get( '/CacheTest' );
				var responseAgain = event.getPrivateValue( 'response' );
				var dataAgain = responseAgain.getData();
			
				var cacheAgain = responseAgain.getCachedResponse();

			//	debug( responseAgain.getHeaders() );
				debug( cacheAgain )
				debug( dataAgain );

				expect( timeStamp ).toBe( dataAgain.timestamp, 'Timestamp values should match even though the second request came in two seconds later' );
			
				expect( cacheAgain ).toBeTrue( 'Response was cached' );
				
			} );
		} );
	}

}
