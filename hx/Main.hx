package;

import js.html.WebSocket;
import js.Browser;
import js.html.MouseEvent;
import js.html.KeyboardEvent;

class Main {

	public static var hidden(default, null) = Comp.Hidden.ofSelector("#hideAll");

	public static var menu(default, null) = Comp.Menu.ofSelector("#menu");

	public static var doclive(default, null) = new Delegate<DocDelegate>();

	static function onDocClick(e: MouseEvent): Void {
		for (i in 0...doclive.length) {
			switch (doclive.get()) {
			case OnMenu: menu.hide();
			}
		}
	}

	static function eventBind() {
		Browser.document.onclick = onDocClick;  // delegate on documentElement

		Browser.document.querySelector("#header .menu-btn").onclick = function (e: MouseEvent) {
			Macros.ie8Event(e);
			e.stopPropagation();
			var cur: js.html.ButtonElement = js.Lib.nativeThis;
			cur.blur();
			menu.show();
		}
	}

	static function main() {
		eventBind();
	}
}

@:forward(length)
extern abstract Delegate<T>(Array<T>) {
	public inline function new() this = [];
	public inline function put(e: T):Void this.push(e);
	public inline function get():Null<T> return this.pop();
	public inline function isEmpty():Bool return this.length == 0;
	public inline function atLast(e: T): Bool return this.length > 0 && js.Syntax.strictEq(this[this.length - 1], e);
}

// delegate on documentElement
@:enum
extern abstract DocDelegate(Int) to Int {
	var OnMenu = 1;
}
