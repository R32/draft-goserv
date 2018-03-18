package;

import js.html.Event;
import js.html.DOMElement;

extern class NodeHeps {
	// IE8 event
	public static inline function hpAttachEvent(dom: DOMElement, name: String, callb: Event->Void, capture: Bool = false): Void {
		if ((dom: Dynamic).addEventListener) {
			dom.addEventListener(name, callb, capture);
		} else {
			(dom: Dynamic).attachEvent("on" + name, callb);
		}
	}

	public static inline function hpDetachEvent(dom: DOMElement, name: String, callb: Event->Void, capture: Bool = false): Void {
		if ((dom: Dynamic).addEventListener) {
			dom.removeEventListener(name, callb, capture);
		} else {
			(dom: Dynamic).detachEvent("on" + name, callb);
		}
	}
}

extern class DomEventHelps {
	public static inline function hpTarget(event: js.html.Event): DOMElement {
		return cast ((event:Dynamic).target != null ? event.target : (event: Dynamic).srcElement);
	}
}