package;

import Settings.SketchType;

@:keep
class GithubVisual extends SketcherBase {
	// ____________________________________
	// size
	var stageW = 1000; // 1024; // video?
	var stageH = 700; // 1024; // video?

	// balls
	var maxDistance = 100;
	var maxBalls = 100;
	var sizeBall = 4;
	var ballArray:Array<Ball> = [];

	// animation
	var timer:Int;

	public function new() {
		var settings:Settings = new Settings(stageW, stageH, SketchType.CANVAS);
		settings.autostart = true;
		settings.padding = 0;
		settings.scale = true;
		settings.elementID = 'canvas-${toString()}';

		super(settings);
	}

	// ____________________________________ setup ____________________________________

	override function setup() {
		description = toString();
		ballArray = [];
		for (i in 0...maxBalls) {
			ballArray.push(createBall());
		}
	}

	function createBall():Ball {
		var ball:Ball = {
			x: random(sizeBall / 2, w - (sizeBall / 2)),
			y: random(sizeBall / 2, h - (sizeBall / 2)),
			speed_x: random(-0.5, 0.5),
			speed_y: random(-0.5, 0.5),
			size: sizeBall,
			colour: rgb(255, 255, 255),
		}
		return ball;
	}

	function moveBall() {
		for (i in 0...ballArray.length) {
			var b = ballArray[i];
			b.x = b.x + b.speed_x;
			b.y = b.y + b.speed_y;
			if (bounce(b.x, 0, w, b.size)) {
				b.speed_x *= -1;
				// b.colour = rgb(randomInt(55),randomInt(255),0);
			}
			if (bounce(b.y, 0, h, b.size)) {
				b.speed_y *= -1;
				// b.colour = rgb(0, randomInt(255),randomInt(55));
			}
		}
	}

	function drawBall() {
		for (i in 0...ballArray.length) {
			var b1 = ballArray[i];
			var circle = sketch.makeCircle(b1.x, b1.y, b1.size);
			circle.setStroke(b1.colour, 1);
			circle.setFill(b1.colour, 0);
			for (j in 0...ballArray.length) {
				var b2 = ballArray[j];
				if (b1 == b2)
					continue;
				var _dist = distance(b1.x, b1.y, b2.x, b2.y);
				if (_dist < maxDistance) {
					var alpha:Float = 0.8 - (_dist / maxDistance); // 0.5
					var line = sketch.makeLine(b1.x, b1.y, b2.x, b2.y);
					line.setStroke(getColourObj(WHITE), 1, alpha);
					line.setLineEnds();
					var circle = sketch.makeCircle(b1.x, b1.y, b1.size);
					circle.setFill(b1.colour, alpha);
				}
			}
		}
	}

	// ____________________________________ canvas animation stuff ____________________________________

	function drawShape() {
		// clear sketch
		sketch.clear();

		// bg
		sketch.makeBackground(getColourObj(SILVER));

		// gradient
		sketch.makeGradient("#4568dc", "#b06ab3");

		// balls
		moveBall();
		drawBall();

		// update sketch, to draw svg or canvas
		sketch.update();
	}

	// ____________________________________ mics / bounce ____________________________________

	/**
	 * check if this `num` is still inbetween `min` and `max` return a true, otherwise a false
	 *
	 * primarily used for bouncing balls
	 *
	 * @param num	value to check
	 * @param min	minimum value
	 * @param max	maximum value
	 * @param sz	(optional) works with centered shapes, is the width of this shape
	 * @return Bool
	 */
	public static function bounce(num:Float, min:Float, max:Float, ?sz:Float = 0):Bool {
		if (num >= max - sz / 2 || num - sz / 2 <= min) {
			return true;
		} else {
			return false;
		}
	}

	// ____________________________________ override ____________________________________

	/**
	 * the magic happens here, every class should have a `draw` function
	 */
	override function draw() {
		// trace('DRAW :: ${toString()} -> override public function draw()');
		drawShape();
	}
}

typedef Ball = {
	var x:Float;
	var y:Float;
	var speed_x:Float;
	var speed_y:Float;
	var size:Int;
	var colour:String;
}
