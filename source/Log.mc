module Log {
	using Toybox.System;
	using Toybox.Application.Storage;
	
	const ERROR = 0;
	const WARN = 1;
	const INFO = 2;
	const DEBUG = 3;
	const TRACE = 4;
	
	const LOGKEY = "logLevel";
	
	function getLL() {
		if (Storage.getValue(LOGKEY) != null) {
			return Storage.getValue(LOGKEY).toNumber();
		} else {
			Storage.setValue(LOGKEY, INFO);
			return INFO;
		}
	}
	
	function write(msg, level) {
		var myTime = System.getClockTime();
		System.println(
		    myTime.hour.format("%02d") + ":" +
		    myTime.min.format("%02d") + ":" +
		    myTime.sec.format("%02d") + " [" +
		  	level +
		    "] " + msg
		);
	}
	
	function info(msg) {
		if (getLL() >= INFO) {
			write(msg, "INFO");
		} 
	}
	
	function error(msg) {
		if (getLL() >= ERROR) {
			write(msg, "ERROR");
		} 
	}
	
	function warn(msg) {
		if (getLL() >= WARN) {
			write(msg, "WARN");
		} 
	}
	
	function debug(msg) {
		if (getLL() >= DEBUG) {
			write(msg, "DEBUG");
		} 
	}
	
	function trace(msg) {
		if (getLL() >= TRACE) {
			write(msg, "TRACE");
		} 
	}
	
}