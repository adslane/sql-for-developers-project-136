create table Courses (
    id bigint primary key generated always as identity,
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table Modules (
    id bigint primary key generated always as identity,
    course_id bigint references Courses (id),
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table Programs (
    id bigint primary key generated always as identity,
    module_id bigint references Courses (id),
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
    teaching_group bigint references TeachingGroups (id),
    created_at timestamp,
    updated_at timestamp
);

create type EnrollmentsStatus as enum ('active'), ('pending'), ('cancelled'), ('completed');

create table Enrollments (
    id bigint primary key generated always as identity,
    user_id bigint references Users (id),
    program_id bigint references Programs (id),
    status_id int references EnrollmentsStatus (id),
    created_at timestamp,
    updated_at timestamp
);

create type PaymentsStatus as enum ('pending'), ('paid'), ('failed'), ('refunded');

create table Payments (
    id bigint primary key generated always as identity,
    status_id int references PaymentsStatus (id),
    day_payment date,
    created_at timestamp,
    updated_at timestamp
);

create type ProgramStatus as enum ('active'), ('completed'), ('pending'), ('cancelled');

create table ProgramCompletions (
    id bigint primary key generated always as identity,
    user_id bigint references Users (id),
    program_id bigint references Programs (id),
    status_id references ProgramStatus (id),
    start_date date,
    end_date date,
    created_at timestamp,
    updated_at timestamp
);

create table Certificates (
    id bigint primary key generated always as identity,
    user_id bigint references Users (id),
    program_id bigint references Programs (id),
    url varchar(255),
    realese_date date,
    created_at timestamp,
    updated_at timestamp
);

create table Quizzes (
    id bigint primary key generated always as identity,
    lesson_id bigint references Lessons (id),
    name varchar(255),
    body text,
    created_at timestamp,
    updated_at timestamp
);

create table Exercises (
    id bigint primary key generated always as identity,
    lesson_id bigint references Lessons (id),
    name varchar(255),
    url varchar(255),
    created_at timestamp,
    updated_at timestamp
);