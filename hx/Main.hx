package;

import js.html.WebSocket;
import js.Browser;
import js.html.MouseEvent;
import js.html.KeyboardEvent;

using DomHelps;

class Main {

	static var hidden = comp.Comm.HideAll.ofSelector("#hideAll");

	static function main() {

		Browser.document.querySelector("#header .menu-btn").onclick = function (e: MouseEvent){
			Macros.ie8Event(e);
			var menu = Browser.document.querySelector("#menu");
			if (menu.className != "popup") { // will use classList instead it.
				menu.className = "popup";
			}
			e.hpTarget().blur();
			e.stopPropagation();
		}

		Browser.document.onclick = function (e: MouseEvent) {
			var menu = Browser.document.querySelector("#menu");
			if (menu.className == "popup") { // maybe need other delagate lib
				menu.className = "";
			}
		}

		hidden.add(Nvd.text("hello world!"));
	}
}