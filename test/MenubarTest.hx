package;
import sakari.menubar.Menubar;
import massive.munit.async.AsyncFactory;
import massive.munit.util.Timer;

class MenubarTest {
    var menu: Menubar;

    @Before
    public function getMenu() {
        menu = Menubar.get();
    }
    
    @Test function add_item() {
        menu.add('Test/Item');
    }

    @AsyncTest function disabled_items_cannot_be_clicked(f) {
        var h = f.createHandler(this, function() {}, 1000);
        menu.add('Test/Disabled/Click')
            .disable('Test/Disabled/Click')
            .listen('Test/Disabled/Click', function() { throw 'should not happen'; })
            .click('Test/Disabled/Click');
        Timer.delay(h, 500);
    }

    @AsyncTest function enabled_items_can_be_clicked(f) {
        menu.add('Test/Click')
            .enable('Test/Click')
            .listen('Test/Click', assertClick(f))
            .click('Test/Click');
    }

    @AsyncTest function multiple_items_can_be_added(f) {
        menu.add('Test/Multi/C1', null, true, assertClick(f))
            .add('Test/Multi/C2', null, true, assertClick(f))
            .click('Test/Multi/C1')
            .click('Test/Multi/C2');
    }

    function assertClick(f: AsyncFactory): (Void -> Void) {
        return f.createHandler(this, clicked, 500);
    }
    function clicked() {
        trace('got click');
    }
}