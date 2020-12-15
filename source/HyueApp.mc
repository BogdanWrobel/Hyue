using Toybox.Application;
using Log;

class HyueApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }
    
    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
    	Log.debug("HyueApp.getInitialView()");
    	var view = new HyueView();
        return [ view, new HyueHandler(view) ];
    }

}