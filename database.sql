create table courses (
    id bigint primary key generated always as identity,
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table modules (
    id bigint primary key generated always as identity,
    course_id int references courses (id),
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table programs (
    id bigint primary key generated always as identity,
    module_id int references courses (id),
    name varchar(255),
    cost int,
    type varchar(255),
    created_at timestamp,
    updated_at timestamp
);

create table lessons (
    id bigint primary key generated always as identity,
    name varchar(255),
    body text,
    link_on_video varchar(255),
    lesson_count int,
    created_at timestamp,
    updated_at timestamp,
    course_id int references courses (id)
);