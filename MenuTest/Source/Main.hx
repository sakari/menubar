package;

import sakari.menubar.Menubar;
import flash.display.Sprite;

class Main extends Sprite {
	public function new () {
		super ();
		var menu = Menubar.get();
		menu.add('Foo/Bar', 'a');
		menu.add('Foo/Buz');
		menu.enable('Foo/Bar');
		menu.listen('Foo/Bar', function() {
		    menu.disable('Foo/Bar');
		    menu.enable('Foo/Buz');
		  });
		menu.listen('Foo/Buz', function() {
		    menu.disable('Foo/Buz');
		    menu.enable('Foo/Bar');
		  });

	}
}