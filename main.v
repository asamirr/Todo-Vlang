module main

import vweb
import sqlite

struct App {
	vweb.Context
	pub mut db sqlite.DB
}


fn main() {
	mut app := App{
		db: sqlite.connect('todos.db') or { panic(err) }
	}

	sql app.db {
		create table TodoList
	}

	first := TodoList{
		title: 'Do the dishes'
		desc: 'Get in the kitchen now!!!!!!'
	}

	sec := TodoList{
		title: 'Do the laundry'
		desc: 'Get in the laundry room now!!!!!!'
	}

	vweb.run(app, 8000)
}

