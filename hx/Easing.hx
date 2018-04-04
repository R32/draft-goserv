package;

class Easing {
	static inline var R90 = 3.141592653589793238 / 2;

	public static inline function linear(t: Float):Float {
		return t;
	}
	public static inline function sineIn(t: Float):Float {
		return 1 - Math.cos(R90 * t);
	}
	public static inline function sineOut(t: Float):Float {
		return Math.sin(R90 * t);
	}
	public static inline function backIn(t: Float):Float {
		return t * t * ((1.70158 + 1) * t - 1.70158);
	}
	public static inline function backOut(t: Float):Float {
		return (t -= 1) * t * ((1.70158 + 1) * t + 1.70158) + 1;
	}
}

class FloatTools {
	public static inline function lerp(k: Float, a: Float, b: Float):Float {
		return a + (b - a) * k;
	}
}

// copy from heaps/hxd/Timer
class LTimer {
	public static inline var wantedFPS = 1000 / Anim.FRAME;
	public static inline var maxDeltaTime = 0.5;
	public static inline var tmod_factor = 0.95;
	public static var oldTime = haxe.Timer.stamp();
	public static var calc_tmod : Float = 1;
	public static var tmod : Float = 1;
	public static var deltaT : Float = 1;
	static var frameCount = 0;
	public static function update() {
		frameCount++;
		var newTime = haxe.Timer.stamp();
		deltaT = newTime - oldTime;
		oldTime = newTime;
		if( deltaT < maxDeltaTime )
			calc_tmod = calc_tmod * tmod_factor + (1 - tmod_factor) * deltaT * wantedFPS;
		else
			deltaT = 1 / wantedFPS;
		tmod = calc_tmod;
	}

	public inline static function fps() : Float {
		return wantedFPS/calc_tmod;
	}
	public static function skip() {
		oldTime = haxe.Timer.stamp();
	}

	public static function reset() {
		oldTime = haxe.Timer.stamp();
		calc_tmod = 1.;
	}
}


/**
  Only for IE8/9.
*/
@:native("anim") abstract Anim(Int) {

	public inline function new(loop: Void->Void) {
		this = js.Syntax.code("setInterval({0}, {1})", loop, FRAME);
	}
	public inline function destory():Void {
		js.Syntax.code("clearInterval({0})", this);
	}

	// example
	public static function demo(): Anim {
		var a = 100;     // from
		var b = 350;     // to
		var c = 0.;      // counter
		var d = 0.6;     // duration
		var step = 1.0 / (LTimer.wantedFPS * d);

		var elem = js.Browser.document.querySelector("div.anim-test");
		if (elem == null) return cast -1;
		var anim: Anim;

		LTimer.reset();
		anim = new Anim(function() {
			LTimer.update();
			var k = Easing.backOut(c);
			var v = FloatTools.lerp(k, a, b);
			elem.style.left = v + "px";  // apply style
			if (c >= 0.9999999) {
				if (false) {             // normal
					anim.destory();
				} else {                 // yoyo
					c = 0;
					a = a + b;           // swap a b
					b = a - b;
					a = a - b;
				}
			} else {
				c += (step * LTimer.tmod);
				if (c >= 0.9999999) c = 1.0;
			}
		});
		return anim;
	}
	public static inline var FRAME = 20; // 1000 / 20 = 50FPS
}
