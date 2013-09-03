package;

import sakari.menubar.Menubar;
import flash.display.Sprite;

class Main extends Sprite {
	public function new () {
		super ();
		var menu = Menubar.get();
		menu.add('Foo/Bar');
		menu.enable('Foo/Bar');
		menu.listen('Foo/Bar', function() {
		    trace('clicked');
		    menu.disable('Foo/Bar');
		  });
	}
}