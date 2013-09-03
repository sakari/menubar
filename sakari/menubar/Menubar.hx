package sakari.menubar;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end


class Menubar {
	public static function sampleMethod (inputValue:Int):Int {
		return menubar_sample_method(inputValue);
	}
	private static var menubar_sample_method = Lib.load ("menubar", "menubar_sample_method", 1);
	
}