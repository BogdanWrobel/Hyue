using Toybox.WatchUi;
using Toybox.System;
using Toybox.Application.Storage;

class MenuHandler extends WatchUi.Menu2InputDelegate {
	var items;
	var comm;
	
    function initialize(_items, _comm) {
        Menu2InputDelegate.initialize();
        me.items = _items;
        me.comm = _comm;
    }

    function onSelect(item) {
		WatchUi.requestUpdate();
		var keys = me.items.keys();
		for (var i = 0; i < keys.size(); i++) {
			if (item.getId().equals(keys[i])) {
				me.comm.setLightState(me.items.get(keys[i]), item.isEnabled(), null, null);
				break;
			}
		}
    }

    function onBack() {
        WatchUi.popView(WatchUi.SLIDE_DOWN);
    }
}