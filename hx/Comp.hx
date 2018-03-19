package;

@:build(Nvd.build("www/index.html", "#hidden"))
extern abstract Hidden(nvd.Comp) {
	public inline function add(c: js.html.Node):Void d.appendChild(c);
}


@:build(Nvd.build("www/index.html", "#menu"))
extern abstract Menu(nvd.Comp) {
	public inline function show(): Void {
		d.className = "popup";
		Main.doclive.put(OnMenu);
	}

	public inline function hide(): Void d.className = "";
}