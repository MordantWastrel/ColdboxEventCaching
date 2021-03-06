component {

	function configure() {
		// Set Full Rewrites
		setFullRewrites( true );

		/**
		 * --------------------------------------------------------------------------
		 * App Routes
		 * --------------------------------------------------------------------------
		 *
		 * Here is where you can register the routes for your web application!
		 * Go get Funky!
		 *
		 */

		// A nice healthcheck route example
		route( "/healthcheck", function( event, rc, prc ) {
			return "Ok!";
		} );

		get( "/", "CacheTest.indexRCOnly" );
		get( "/CacheTest", "CacheTest.indexRCOnly" );
		get( "/EventArgs", "CacheTest.indexEventArgs" );

		// Conventions based routing
		route( ":handler/:action?" ).end();
	}

}
