module main
import json
import vweb
import sqlite

struct App {
	vweb.Context
	pub mut:
		db sqlite.DB
}


fn main() {
	mut app := App{
		db: sqlite.connect('todos.db') or { panic(err) }
	}

	sql app.db {
		create table Todo
	}

	first := Todo{
		title: 'Do the dishes'
		desc: 'Get in the kitchen now!!!!!!'
	}

	sec := Todo{
		title: 'Do the laundry'
		desc: 'Get in the laundry room now!!!!!!'
	}
	sql app.db {
		insert first into Todo
		insert sec into Todo
	}
	vweb.run(app, 8000)
}

['/'; get]
pub fn (mut app App) index() vweb.Result {
	todos := app.find_all_todos()
	return app.json(json.encode(todos))
}