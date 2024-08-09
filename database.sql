create table Courses (
    id bigint primary key generated always as identity,
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table Modules (
    id bigint primary key generated always as identity,
    course_id int references Courses (id),
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table Programs (
    id bigint primary key generated always as identity,
    module_id int references Courses (id),
    name varchar(255),
    cost int,
    type varchar(255),
    created_at timestamp,
    updated_at timestamp
);

create table Lessons (
    id bigint primary key generated always as identity,
    name varchar(255),
    body text,
    link_on_video varchar(255),
    lesson_count int,
    created_at timestamp,
    updated_at timestamp,
    course_id int references Courses (id)
);

create table TeachingGroups (
    id bigint primary key generated always as identity,
    slack varchar(255),
    created_at timestamp,
    updated_at timestamp
);

create table Users (
    id bigint primary key generated always as identity,
    name varchar(255),
    email varchar(255),
    password_hash varchar(255),
    role varchar(50),
    teaching_group int references TeachingGroups (id),
    created_at timestamp,
    updated_at timestamp
);