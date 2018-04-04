package;

import js.html.DOMElement;

@:build(Nvd.build("www/index.html", "#hidden"))
extern abstract Hidden(nvd.Comp) {
	public inline function add(c: js.html.Node):Void d.appendChild(c);
}

// menu
@:build(Nvd.build("www/index.html", "#menu"))
extern abstract Menu(nvd.Comp) {
	public inline function show():Void {
		d.className = "popup";
		Main.doclive.put(OnMenu);
	}
	public inline function hide():Void d.className = "";
}

// blockinfo
@:build(Nvd.build("www/index.html", "#blockinfo", {
	blink: Attr(null, "class"),
	height : Prop("h2", "textContent"),
	hash0  : Prop("p .hash-0", "textContent"),
	hash1  : Prop("p .hash-1", "textContent"),
	hash2  : Prop("p .hash-2", "textContent"),
}))
extern abstract BlockInfo(nvd.Comp) {
	public inline function activing():Bool return blink == "active";
	public inline function on():Void blink = "active";
	public inline function off():Void blink = "";

	var hash(get, set): String;
	inline function get_hash(): String return hash0 + hash1 + hash2;
	inline function set_hash(s: String): String {
		hash0 = s.substr( 0, 32);
		hash1 = s.substr(32, 31);
		hash2 = s.substr(63,  1);
		return s;
	}
}


// notice
@:build(Nvd.build("www/index.html", "#msgWarning", {
	btn: Elem(".close"),
	text: Prop("span", "textContent"),
}))
abstract Warning(nvd.Comp) {
	public inline function show():Void d.classList.add("popup");
	public inline function hide():Void d.classList.remove("popup");

	public inline function new(d: DOMElement) {
		this = cast d;
		if (btn.onclick == null) btn.onclick = onClose;
	}
	static function onClose(e: js.html.MouseEvent): Void {
		Macros.ie8Event(e);
		e.stopPropagation();
		var tar: js.html.DOMElement = cast e.target;
		var w: Warning = cast tar.parentNode;
		w.hide();
	}
}
