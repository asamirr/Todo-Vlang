module main

import vweb
import time

struct App {
	vweb.Context
}

fn main() {
	app := App{}
	vweb.run(app, 8081)
}

['/']
pub fn (mut app App) index() vweb.Result {
	return app.text(time.now().format())
}