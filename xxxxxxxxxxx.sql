CREATE TABLE "books"
(
    "id"         integer primary key autoincrement not null,
    "title"      varchar not null
);

CREATE TABLE "users"
(
    "id"           integer primary key autoincrement not null,
    "name"        varchar not null
);

CREATE TABLE "user_books"
(
    "id"         integer primary key autoincrement not null,
    "user_id"    integer not null,
    "book_id"     integer not null,
    foreign key ("user_id") references "users" ("id"),
    foreign key ("book_id") references "books" ("id")
);

CREATE INDEX "user_book_user_idx" on "user_books" ("user_id");
CREATE INDEX "user_book_book_idx" on "user_books" ("book_id");