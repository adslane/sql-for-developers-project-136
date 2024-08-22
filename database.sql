create table courses (
    id bigint primary key generated always as identity,
    title varchar(255),
    description text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    deleted_at timestamp
);

create table modules (
    id bigint primary key generated always as identity,
    title varchar(255),
    description text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    deleted_at timestamp
);

create table programs (
    id bigint primary key generated always as identity,
    name varchar(255),
    price int,
    program_type varchar(255),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

create table lessons (
    id bigint primary key generated always as identity,
    title varchar(255),
    content text,
    video_url varchar(255),
    position int,
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    course_id bigint references courses (id),
    deleted_at timestamp
);

create table course_modules (
    course_id bigint references courses (id),
    module_id bigint references modules (id),
    primary key (module_id, course_id)
);

create table program_modules (
    program_id bigint references programs (id),
    module_id bigint references modules (id),
    primary key (program_id, module_id)
);

create table teaching_groups (
    id bigint primary key generated always as identity,
    slug varchar(255),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp
);

create table users (
    id bigint primary key generated always as identity,
    name varchar(255),
    email varchar(255),
    password_hash varchar(255),
    role varchar(50),
    teaching_group_id bigint references teaching_groups (id),
    created_at timestamp default current_timestamp,
    updated_at timestamp default current_timestamp,
    deleted_at timestamp
);

create type enrollments_status as enum (
    'active',
    'pending',
    'cancelled',
    'completed'
);

create table enrollments (
    id bigint primary key generated always as identity,
    user_id bigint references users (id),
    program_id bigint references programs (id),
    status enrollments_status,
    created_at timestamp,
    updated_at timestamp
);

create type payments_status as enum (
    'pending',
    'paid',
    'failed',
    'refunded'
);

create table payments (
    id bigint primary key generated always as identity,
    enrollment_id bigint references enrollments (id),
    amount int,
    status payments_status,
    paid_at date,
    created_at timestamp,
    updated_at timestamp
);

create type program_status as enum (
    'active',
    'completed',
    'pending',
    'cancelled'
);

create table program_completions  (
    id bigint primary key generated always as identity,
    user_id bigint references users (id),
    program_id bigint references programs (id),
    status program_status,
    started_at date,
    completed_at date,
    created_at timestamp,
    updated_at timestamp
);

create table certificates (
    id bigint primary key generated always as identity,
    user_id bigint references users (id),
    program_id bigint references programs (id),
    url varchar(255),
    issued_at date,
    created_at timestamp,
    updated_at timestamp
);

create table quizzes (
    id bigint primary key generated always as identity,
    lesson_id bigint references lessons (id),
    title varchar(255),
    content text,
    created_at timestamp,
    updated_at timestamp
);

create table exercises (
    id bigint primary key generated always as identity,
    lesson_id bigint references lessons (id),
    name varchar(255),
    url varchar(255),
    created_at timestamp,
    updated_at timestamp
);

create table discussions (
    id bigint primary key generated always as identity,
    lesson_id bigint references lessons (id),
    user_id bigint references users (id),
    text text,
    created_at timestamp,
    updated_at timestamp
);

create type blog_status as enum (
    'created',
    'in moderation',
    'published',
    'archived'
);

create table blogs (
    id bigint primary key generated always as identity,
    user_id bigint references users (id),
    title varchar(255),
    content text,
    status blog_status,
    created_at timestamp,
    updated_at timestamp
);

