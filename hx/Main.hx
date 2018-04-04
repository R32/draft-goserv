package;

import js.html.WebSocket;
import js.Browser.document;
import js.html.MouseEvent;

class Main {

	public static final hidden = Comp.Hidden.ofSelector("#hidden");

	public static final menu = Comp.Menu.ofSelector("#menu");

	public static final warn = Comp.Warning.ofSelector("#msgWarning");

	public static final blockinfo = Comp.BlockInfo.ofSelector("#blockinfo");

	public static final doclive = new Delegate<DocDelegate>();

	static function onDocClick(e: MouseEvent): Void {
		for (i in 0...doclive.length) {
			switch (doclive.get()) {
			case OnMenu: menu.hide();
			}
		}
	}

	static function eventbind() {
		document.onclick = onDocClick;  // delegate on documentElement

		document.querySelector("#header .menu-btn").onclick = function (e: MouseEvent) {
			Macros.ie8Event(e);
			e.stopPropagation();
			var cur: js.html.ButtonElement = js.Lib.nativeThis;
			cur.blur();
			menu.show();
		}

		document.querySelector("#menu .content a").onclick = function(e: MouseEvent) {
			warn.show();
		}
	}

	static function main() {
		eventbind();
	}
}

@:forward(length)
extern abstract Delegate<T>(Array<T>) {
	public inline function new() this = [];
	public inline function put(e: T):Void this.push(e);
	public inline function get():Null<T> return this.pop();
	public inline function isEmpty():Bool return this.length == 0;
	public inline function atLast(e: T): Bool return this.length > 0 && this[this.length - 1] == e;
}

// delegate on documentElement
@:enum
extern abstract DocDelegate(Int) to Int {
	var OnMenu = 1;
}
