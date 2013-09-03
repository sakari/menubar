package sakari.menubar;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end


class Menubar {
  
    static var instance: Menubar;
    
    var paths: Map<String, Int>;
    var indexToPath: Map<Int, String>;
    var listeners: Map<String, Void -> Void>;
    
    private function new() {
        paths = new Map();
        indexToPath = new Map();
        listeners = new Map();
        setListener(function(tag: Int) {
                var p = indexToPath[tag];
                if(p == null) return;
                var cb = listeners[p];
                if(cb == null) return;
                cb();
            });
    }
    
    public static function get(): Menubar {
        if(instance == null) instance = new Menubar();
        return instance;
    }
    
    public function add(path: String) {
        trace('adding $path');
        var i = addMenuItem(path);
        paths[path] = i;
        indexToPath[i] = path;
    }
    
    public function enable(path: String) {
        var i = paths[path];
        enableItem(i);
    }
    
    public function disable(path: String) {
        var i = paths[path];
        disableItem(i);
    }
    
    public function listen(path: String, cb: Void -> Void) {
        listeners[path] = cb;
    }
    
    public static function sampleMethod (inputValue:Int):Int {
        return menubar_sample_method(inputValue);
    }
    
    private static var setListener = Lib.load ("menubar", "setListener", 1);
    private static var addMenuItem = Lib.load ("menubar", "addMenuItem", 1);
    private static var enableItem = Lib.load ("menubar", "enableItem", 1);
    private static var disableItem = Lib.load ("menubar", "disableItem", 1);
    private static var menubar_sample_method = Lib.load ("menubar", "menubar_sample_method", 1);
}