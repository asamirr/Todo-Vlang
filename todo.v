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

pub fn (app &App) update_todo(id int, title string, desc string) {
	sql app.db {
		update Todo
		set title = title, desc = desc where id == id
	}
} 