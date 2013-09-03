# Menubar

Create menus to the main menubar of the application from openfl.

Supports only OSX now as I don't have any other platforms. Pull request welcome.

## Usage

    import sakari.menubar.Menubar;
    ..
    var m = Menubar.get()
    m.add('Foo/Bar', 'a'); //use 'a' as shortcut key
    m.enable('Foo/Bar');
    m.listen('Foo/Bar', function() {
        trace('Foo/Bar was clicked, will disable it now');
        m.disable('Foo/Bar');
    });

## Building from source

    make

## Building the test app

    make test

## License

(c) Sakari Jokinen

MIT
