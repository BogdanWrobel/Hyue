using Toybox.Application;
using Toybox.System;
using Toybox.Communications;
using Toybox.Application.Storage;
using Log;

class HyueComm {
	const TOKEN = "R79v8hfyz6I74SFrCIAdA58aI31BBpoDjLOf5bWO";
	const IP = "192.168.1.43";
	const PROTO = "https://";

	function getBridgeIp(success, error) {
		Log.info("HyueComm.getBridgeIp()");
		makeWebRequest("https://discovery.meethue.com/", null, null, success, error);
	}
	
	function pingBridge(success, error) {
		Log.info("HyueComm.pingBridge()");
		makeWebRequest(PROTO + IP + "/licenses/curl.txt", null, null, success, error);
	}

	function getLights(success, error) {
    	Log.info("HyueComm.getLights()");
    	makeWebRequest(PROTO + IP + "/api/" + TOKEN + "/lights", null, null, success, error);
	}
	
	function setLightState(light, state, success, error) {
    	Log.info("HyueComm.setLightState()");
    	Log.debug("light: " + light);
    	Log.debug("state: " + state);
    	makeWebRequest(
    		PROTO + IP + "/api/" + TOKEN + "/lights/" + light + "/state",
    		{ "on" => state }, Communications.HTTP_REQUEST_METHOD_PUT,
    		success, error
    	);
	}

    function makeWebRequest(url, data, method, success, error) {
    	Log.debug("HyueComm.makeWebRequest()");
    	Log.debug("url: " + url);
    	Log.trace("data: " + data);
    	Log.trace("method: " + method);
    	Log.trace("success: " + success);
    	Log.trace("error: " + error);
    	if (method == null) {
    		Log.debug("Method is not a number, falling back to GET");
    		method = Communications.HTTP_REQUEST_METHOD_GET;
    	}
    	var ctx = {
    		:url => url,
    		:method => httpMethodToString(method)
    	};
    	if (success != null && success instanceof Lang.Method) {
    		ctx.put(:success, success);
    	} else {
    		Log.debug("No success handler: " + url);
    	}
    	
    	if (error != null && error instanceof Lang.Method) {
    		ctx.put(:error, error);
    	} else {
    		Log.debug("No error handler: " + url);
    	}
    	
    	var options = {
    		:method => method,
    		:context => ctx
    	};
    	
    	if (data != null) {
    		Log.trace("Setting Content-Type and responseType header.");
    		options.put(:headers, {"Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON});
    		options.put(:responseType, Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON);
    	}	
    	
    	Communications.makeWebRequest(url, data, options, method(:handler));
    }
    
    function handler(code, data, ctx) {
    	Log.debug("HyueComm.handler()");
    	Log.trace("Handling " + ctx.get(:method) + " response for " + ctx.get(:url));
    	if (code == 200) {
    		// Hue-specific error:
    		if (data != null && data instanceof Lang.Array && data.size() > 0 && data[0].hasKey("error")) {
    			if (ctx.get(:error) instanceof Lang.Method) {
    				ctx.get(:error).invoke(data[0].get("error").get("type"), data);
    			} else {
	    			Log.warn("Hue-specific error occured, no handler defined.");
	    			Log.warn("Error details: " + data[0].get("error"));
    			}
    		} else {
    			if (ctx.get(:success) instanceof Lang.Method) {
	    			ctx.get(:success).invoke(code, data);
	    		} else {
	    			Log.trace("Request successful, no success handler given.");
	    		}
    		}
    	} else {
    		Log.trace("code: " + code);
    		Log.trace("data: " + data);
	    	if (ctx.get(:error) instanceof Lang.Method) {
	    		ctx.get(:error).invoke(code, data);
	    	} else {
	    		Log.warn("No error handler given, yet error occurred!");
	    	}
    	}
    }
    
    function httpMethodToString(httpMethod) {
    	Log.trace("HyueComm.httpMethodToString()");
    	Log.trace("method: " + httpMethod);
        var method = "UNKNOWN";
    	switch (httpMethod) {
    		case Communications.HTTP_REQUEST_METHOD_GET:
    			method = "GET";
    			break;
			case Communications.HTTP_REQUEST_METHOD_POST:
				method = "POST";
				break;
			case Communications.HTTP_REQUEST_METHOD_PUT:
				method = "PUT";
				break;
			case Communications.HTTP_REQUEST_METHOD_DELETE:
				method = "DELETE";
				break;
    	}
    	return method;
    }
    	
//	function thenAuth(responseCode, data) {
//		var ip = onReceive(responseCode, data);
//				Storage.setValue("ip", ip);
//		
//		System.println("IP received: " + ip);
//		if (ip == "") {
//			System.println("ERROR!");
//		} else {
//			authenticateBridge(ip);
//		}
//	}
//
//	function authenticateBridge(ip) {
//    	System.println("auth");
//    	var body = {
//    		"devicetype" => "hyue_app#garmin watch"
//    	};
//    	
//    	Communications.makeWebRequest("https://" + ip + "/api", body,
//    		{
//    			:method => Communications.HTTP_REQUEST_METHOD_POST,
//    			:responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
//    			:headers => {
//    				"Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON,
//    				"Accept" => "application/json"
//    			}
//    		},
//    		method(:handleAuthResponse)
//    	);
//	}
//
//	function handleAuthResponse(responseCode, data) {
//		System.println("code: " + responseCode);
//		System.println("data: " + data);
//	}
}