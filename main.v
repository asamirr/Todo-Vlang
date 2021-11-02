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

	// first := Todo{
	// 	title: 'Do the dishes'
	// 	desc: 'Get in the kitchen now!!!!!!'
	// }
	// sql app.db {
	// 	insert first into Todo
	// }
	vweb.run(app, 8000)
}

['/'; get]
pub fn (mut app App) index() vweb.Result {
	todos := app.find_all_todos()
	// println(todos)
	return app.json(todos)
}

['/add/:title/:desc'; post]
pub fn (mut app App) post(title string, desc string) vweb.Result {
	if title == '' || desc == '' {
		return app.text('Please enter your todo item')
	}

	todo := Todo{
		title: title
		desc: desc
	}
	println(todo)

	sql app.db {
		insert todo into Todo
	}
	return app.redirect('/')
}