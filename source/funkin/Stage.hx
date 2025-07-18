package;

import flixel.group.FlxGroup;
import openfl.Assets;
import modding.HScript;
import yaml.*;

class Stage extends FlxGroup
{
	public var name:String;
	public var script:HScript;

	public var foreground:FlxGroup = new FlxGroup();

	override public function new(name:String)
	{
		super();
		
		this.name = name;
		var scriptPath = "assets/data/stages/" + name + ".hscript";
		if (Assets.exists(scriptPath))
		{
			script = new HScript(scriptPath);
			script.scriptObject = PlayState.instance;
			script.variables.set("add", this.add);
			script.variables.set("remove", this.remove);
			script.variables.set("foreground", this.foreground);
		}
	}
}