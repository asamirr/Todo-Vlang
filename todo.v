module main

struct Todo {
	id    int    [primary; sql: serial]
	title string
	desc  string
}

pub fn (app &App) find_all_todos() []Todo {
	return sql app.db {
		select from Todo
	}
}