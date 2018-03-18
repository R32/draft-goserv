package;

class Macros {
	// http://stackoverflow.com/questions/857439/internet-explorer-and-javascript-event-currenttarget
	macro public static function ie8Event(event) return macro @:mergeBlock {
		if ($event == null) $event = (js.Browser.window: Dynamic).event;
	}
}