using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;
using Log;

class HyueHandler extends WatchUi.BehaviorDelegate {
	var view;
	var comm;

    function initialize(_view) {
    	Log.debug("HyueHandler.initialize(" + _view + ")");
        BehaviorDelegate.initialize();
        me.view = _view.weak();
        me.comm = new HyueComm();
    }

	function buildMenu(code, data) {
		Log.debug("HyueHandler.buildMenu()");
		Log.debug("code: " + code);
		Log.debug("data: " + data);
		
		var map = {};
		var keys = data.keys();
		var size = data.size();
		var menu = new WatchUi.Menu2({
			:title => @Rez.Strings.MenuTitle
		});

		for (var i = 0; i < size; i++) {
			menu.addItem(new WatchUi.ToggleMenuItem (
                data[keys[i]]["name"],
                keys[i] + ": " + data[keys[i]]["modelid"],
                "item" + i,
                data[keys[i]]["state"]["on"],
                {}
            ));
			map.put("item" + i, keys[i]);
		}
		
		WatchUi.pushView(menu, new MenuHandler(map, me.comm), WatchUi.SLIDE_UP);
	}
	
	function setLabel(text) {
		Log.debug("HyueHandler.setLabel(" + text + ")");
		if (me.view.stillAlive()) {
			me.view.get().findDrawableById("id_mainlabel").setText(text);
			me.view.get().requestUpdate();
		}
	}
	
//	function updateBridgeIp(code, data) {
//		if (data != null && data.size() > 0 && data[0].hasKey("internalipaddress")) {
//			setLabel(data[0]["internalipaddress"]);
//		} else {
//			setLabel("??");
//		}
//	}
	
	function errorHandler(code, data) {
		setLabel("E: " + code);
	}

	function onSelect() {
		comm.getLights(method(:buildMenu), method(:errorHandler));
		return true;
	}
}