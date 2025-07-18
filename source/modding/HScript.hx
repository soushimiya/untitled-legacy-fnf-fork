package modding;

import hscript.*;
import flixel.util.FlxDestroyUtil;

class HScript extends Interp implements IFlxDestroyable
{
	private var parser:Parser;

	override public function new(path:String)
	{
		super();
		this.allowStaticVariables = this.allowPublicVariables = true;

		parser = new Parser();
		parser.allowJSON = parser.allowTypes = parser.allowMetadata = true;
		var parsed = parser.parseString(openfl.Assets.getText(path));

		// default variables
		variables.set("Reflect", Reflect);
		variables.set("Type", Type);
		variables.set("Std", Std);

		variables.set("FlxBasic", flixel.FlxBasic);
		variables.set("FlxObject", flixel.FlxObject);
		variables.set("FlxSprite", flixel.FlxSprite);

		execute(parsed);
	}

	public function destroy()
	{
		callFunc("destroy");
		parser = null;
	}

	public function callFunc(func:String, args:Array<Dynamic> = null):Dynamic
	{
		if (!variables.exists(func))
			return null;

		if (Reflect.isFunction(variables.get(func)))
			return Reflect.callMethod(null, variables.get(func), args);
		return null;
	}
}