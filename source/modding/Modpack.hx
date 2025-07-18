package modding;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

class Modpack
{
	public var name:String = "Mod Name";
	public var id:String = "";
	public var folder:String = "";

	public function new(name:String, id:String, folder:String):Void
	{
		this.name = name;
		this.id = id;
		this.folder = folder;
	}

	public static inline function fromFolder(folder:String):Null<Modpack>
	{
		if (FileSystem.exists('${Mods.MOD_ROOT}/$folder/modpack.json')){
			var meta = Json.parse(File.getContent('${Mods.MOD_ROOT}/$folder/modpack.json'));

			if (meta.id == null)
				meta.id = folder;
			if (meta.name == null)
				meta.name = meta.id;

			var pack = new Modpack(name, id, folder);
			return pack;
		}

		return null;
	}
}