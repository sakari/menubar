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

    public function click(path: String): Menubar {
        clickItem(path);
        return this;
    }
    
    public static function get(): Menubar {
        if(instance == null) instance = new Menubar();
        return instance;
    }
    
    public function add(path: String, ?shortcut: String, ?enabled, ?cb): Menubar {
        var i = addMenuItem(path, shortcut);
        paths[path] = i;
        indexToPath[i] = path;
        if(enabled != null)
            enable(path);
        if(cb != null)
            listen(path, cb);
                
        return this;
    }
    
    public function on(path: String): Menubar {
        onItem(path);
        return this;
    }

    public function off(path: String): Menubar {
        offItem(path);
        return this;
    }

    public function mixed(path: String): Menubar {
        mixedItem(path);
        return this;
    }
    
    public function enable(path: String): Menubar {
        var i = paths[path];
        enableItem(i);
        return this;
    }
    
    public function disable(path: String): Menubar {
        var i = paths[path];
        disableItem(i);
        return this;
    }
    
    public function listen(path: String, cb: Void -> Void): Menubar {
        listeners[path] = cb;
        return this;
    }
    
    private static var clickItem = Lib.load("menubar", "clickItem", 1);
    private static var setListener = Lib.load ("menubar", "setListener", 1);
    private static var addMenuItem = Lib.load ("menubar", "addMenuItem", 2);
    private static var enableItem = Lib.load ("menubar", "enableItem", 1);
    private static var disableItem = Lib.load ("menubar", "disableItem", 1);
    private static var offItem = Lib.load ("menubar", "offItem", 1);
    private static var onItem = Lib.load ("menubar", "onItem", 1);
    private static var mixedItem = Lib.load ("menubar", "mixedItem", 1);
}