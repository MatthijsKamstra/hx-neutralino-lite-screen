package;

import global.IndexGlobal.*;
import global.Neutralino;
import js.Browser.*;

// @:build(tools.Macro.buildTemplate(true))
class Main {
	public function new() {
		trace('Main');

		// tools.Macro.buildTemplate(true);
		// var settings = new neu.Settings();
		// tools.Macro.settings(settings);

		Neutralino.init({
			load: function() {
				init();
			},

			pingSuccessCallback: function() {},
			pingFailCallback: function() {}
		});
	}

	function init() {
		// Dom.body().appendChild(Dom.html('<h1>Welcome to NPM + Haxe</h1>'));
		var art = new GithubVisual();
	}

	static public function main() {
		var app = new Main();
	}
}
