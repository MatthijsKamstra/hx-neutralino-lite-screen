package tools;

import haxe.io.Path;
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
import sys.FileSystem;
import sys.io.File;

using StringTools;

#if macro
class Macro {
	/**
	 * @example
	 * 			--macro tools.Macro.buildTemplates(true)
	 *
	 * @param overwrite
	 * @param folder
	 * @return Array<Field>
	 */
	public static function buildTemplates(?overwrite:Bool = false, ?folder:String = 'docs', ?js:String = '') {
		var cwd:String = Sys.getCwd();
		trace(cwd);
		var exportFolder = Path.join([cwd, folder]);
		// trace(exportFolder);
		if (FileSystem.exists(exportFolder)) {
			// generateTemplate(exportFolder, js);
		} else {
			Context.warning('You might be using a different folder structure: this will not work!', Context.currentPos());
		}
	}

	/**
	 * @example
	 * 			@:build(tools.Macro.buildTemplate(true))
	 *
	 * @param overwrite
	 * @return Array<Field>
	 */
	public static function buildTemplate(?overwrite:Bool = false):Array<Field> {
		// get the current fields of the class
		var fields:Array<Field> = Context.getBuildFields();

		// trace(fields);

		// get the path of the current current class file, e.g. "src/path/to/MyClassName.hx"
		var posInfos = Context.getPosInfos(Context.currentPos());
		var directory = Path.directory(posInfos.file);

		// get the current class information.
		var ref:ClassType = Context.getLocalClass().get();
		// path to the template. syntax: "MyClassName.template"
		// var filePath:String = Path.join([directory, ref.name + ".template"]);

		// trace(filePath);

		trace("directory: " + directory);

		var filePathHtml:String = Path.join([directory, "../bin", ref.name.toLowerCase() + ".html"]);
		var filePathHxml:String = Path.join([directory, "../", "build_all.hxml"]);

		var file = {name: ref.name.toLowerCase(), date: Date.now()};

		trace(file);
		// var template = new haxe.Template(html);
		// var output = template.execute(file);

		// if (!FileSystem.exists(filePathHtml)) {
		// 	// trace("file doesn't exists");
		// 	File.saveContent(filePathHtml, output);
		// } else {
		// 	if (overwrite) {
		// 		// trace("file exists but we want to overwrite it");
		// 		File.saveContent(filePathHtml, output);
		// 	}
		// }

		// File.saveContent(filePathHxml, strHxml);
		// File.saveContent('bin/nav.html', '<ul>\n$strHtml</ul>');

		// detect if template file exists
		// if (FileSystem.exists(filePath)) {
		// get the file content of the template
		// var fileContent:String = File.getContent(filePath);
		// }

		return fields;
	}

	macro static public function settings():Expr {
		// Grab the variables accessible in the context the macro was called.
		var locals = Context.getLocalVars();
		var fields = Context.getLocalClass().get().fields.get();

		var exprs:Array<Expr> = [];
		// for (local in locals.keys()) {
		// 	if (fields.exists(function(field) return field.name == local)) {
		// 		exprs.push(macro this.$local = $i{local});
		// 	} else {
		// 		throw new Error(Context.getLocalClass() + " has no field " + local, Context.currentPos());
		// 	}
		// }
		// Generates a block expression from the given expression array
		return macro $b{exprs};
	}
}
#end
