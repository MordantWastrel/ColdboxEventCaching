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

	function indexRCOnly( event, rc, prc ) {

		var insideEvent = runEvent(
			event = 'CacheTest._indexRCOnly',
			private = true,
			cache = true,
			prePostExempt = true,
			eventArguments = { 'someInput' : event.getValue( 'someInput', '1' ) }
		);

		return insideEvent;
	}

	private function _indexRCOnly( event, rc, prc ) cache=true {
		return event.getResponse().setData( {
			'timestamp' : now(),
			'someInput' : event.getValue( 'someInput', 'RCOnlyDefault' ) 
		} );
	}

	function indexEventArgs( event, rc, prc ) {

		var responseValue = runEvent(
			event = 'CacheTest._index',
			private = true,
			cache = true,
			prePostExempt = true,
			eventArguments = { 'someInput' : event.getValue( 'someInput', '1' ) }
		);

		return response;
	}

	private function _indexEventArgs( event, rc, prc, string someInput = 'default' ) {
		return event.getResponse().setData( {
			'timestamp' : now(),
			'someInput' : arguments.someInput
		});
	} 
}