package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:sizei16621y4:typey5:MUSICy2:idy18:assets%2Fclick.mp3y9:pathGroupaR4hy7:preloadtgoR0i155310R1R2R3y17:assets%2Floop.mp3R5aR7hR6tgoR0i959064R1R2R3y18:assets%2Fmusic.mp3R5aR8hR6tgoR0i21316R1R2R3y18:assets%2Fsolo1.mp3R5aR9hR6tgoR0i31332R1R2R3y18:assets%2Fsolo2.mp3R5aR10hR6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_click_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_loop_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_solo1_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_solo2_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("Assets/click.mp3") @:noCompletion #if display private #end class __ASSET__assets_click_mp3 extends haxe.io.Bytes {}
@:keep @:file("Assets/loop.mp3") @:noCompletion #if display private #end class __ASSET__assets_loop_mp3 extends haxe.io.Bytes {}
@:keep @:file("Assets/music.mp3") @:noCompletion #if display private #end class __ASSET__assets_music_mp3 extends haxe.io.Bytes {}
@:keep @:file("Assets/solo1.mp3") @:noCompletion #if display private #end class __ASSET__assets_solo1_mp3 extends haxe.io.Bytes {}
@:keep @:file("Assets/solo2.mp3") @:noCompletion #if display private #end class __ASSET__assets_solo2_mp3 extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else



#end

#if (openfl && !flash)

#if html5

#else

#end

#end
#end

#end