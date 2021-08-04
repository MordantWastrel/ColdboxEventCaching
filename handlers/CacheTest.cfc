/**
 * My RESTFul Event Handler
 */
component extends="coldbox.system.RestHandler" {

	// OPTIONAL HANDLER PROPERTIES
	this.prehandler_only      = "";
	this.prehandler_except    = "";
	this.posthandler_only     = "";
	this.posthandler_except   = "";
	this.aroundHandler_only   = "";
	this.aroundHandler_except = "";

	// REST Allowed HTTP Methods Ex: this.allowedMethods = {delete='POST,DELETE',index='GET'}
	this.allowedMethods = {};

	function preHandler( event, rc, prc ) {
		rc.testCacheKey = 'sam@inleague.io';
	}

	this.event_cache_suffix = ( eventHandlerBean ) => {
		return 'testCache_' & rc.testCacheKey;
	}

	function indexRCOnly( event, rc, prc ) {

		systemOutput( this.event_cache_suffix );

		var templateCache = cachebox.getCache( 'template' );
		
		if ( event.getValue( 'bustCache', 0 ) ) {
			// test clearing cache by testCacheKey
			templateCache.clearEvent( 'testCache_');
			systemOutput( 'clearing Cache!' );
		}

		var insideEvent = runEvent(
			event = 'CacheTest._indexRCOnly',
			private = true,
			cache = true,
			prePostExempt = true,
			eventArguments = { 'someInput' : event.getValue( 'someInput', '1' ) }
		);

		prc.response = insideEvent;
	}

	private function _indexRCOnly( event, rc, prc ) cache=true {
		return event.getResponse().setData( {
			'timestamp' : now(),
			'someInput' : event.getValue( 'someInput', 'RCOnlyDefault' ) 
		} );
	}

	function indexEventArgs( event, rc, prc ) {
		dump('eventArgs');
		var responseValue = runEvent(
			event = 'CacheTest._indexEventArgs',
			private = true,
			cache = true,
			prePostExempt = true,
			eventArguments = { 'someInput' : event.getValue( 'someInput', '1' ) }
		);

		prc.response = responseValue;
	}

	private function _indexEventArgs( event, rc, prc, string someInput = 'default' ) {
		return event.getResponse().setData( {
			'timestamp' : now(),
			'someInput' : arguments.someInput
		});
	} 
}