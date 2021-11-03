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

	vweb.run(app, 8000)
}

['/'; get]
pub fn (mut app App) index() vweb.Result {
	todos := app.find_all_todos()
	// println(todos)
	return app.json(todos)
}

['/add'; post]
pub fn (mut app App) post() vweb.Result {
	data := app.req.data
	todo := json.decode(Todo, data) or {
		return app.text('Error parsing json')
	}

	sql app.db {
		insert todo into Todo
	}

	return app.redirect('/')
}