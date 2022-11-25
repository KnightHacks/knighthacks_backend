create table sponsors
(
    id          serial,
    name        varchar           not null,
    tier        subscription_tier not null,
    since       date              not null,
    description varchar,
    website     varchar,
    logo_url    varchar,
    constraint sponsors_pk
        primary key (id, name)
);

alter table sponsors
    owner to postgres;

create unique index sponsors_id_uindex
    on sponsors (id);

create unique index sponsors_name_uindex
    on sponsors (name);

create table terms
(
    id       serial
        constraint terms_pk
            primary key,
    year     integer  not null,
    semester semester not null
);

alter table terms
    owner to postgres;

create unique index terms_id_uindex
    on terms (id);

create table hackathons
(
    id         serial
        constraint hackathons_pk
            primary key,
    term_id    serial
        constraint hackathons_terms_id_fk
            references terms,
    start_date timestamp not null,
    end_date   timestamp not null
);

alter table hackathons
    owner to postgres;

create unique index hackathons_id_uindex
    on hackathons (id);

create unique index hackathons_term_id_uindex
    on hackathons (term_id);

create table pronouns
(
    id         serial
        constraint pronouns_pk
            primary key,
    subjective varchar not null,
    objective  varchar not null
);

alter table pronouns
    owner to postgres;

create unique index pronouns_id_uindex
    on pronouns (id);

create table users
(
    id             serial,
    email          varchar not null,
    phone_number   varchar,
    last_name      varchar not null,
    age            integer,
    pronoun_id     integer
        constraint users_pronouns_id_fk
            references pronouns,
    first_name     varchar not null,
    role           varchar not null,
    oauth_uid      varchar not null,
    oauth_provider varchar not null,
    gender         varchar,
    race           character varying[],
    shirt_size     varchar not null,
    constraint users_pk
        primary key (id, oauth_uid)
);

alter table users
    owner to postgres;

create unique index users_email_uindex
    on users (email);

create unique index users_phone_number_uindex
    on users (phone_number);

create table hackathon_sponsors
(
    hackathon_id integer not null,
    sponsor_id   integer not null
);

alter table hackathon_sponsors
    owner to postgres;

create table events
(
    id           serial
        constraint events_pk
            primary key,
    hackathon_id integer   not null
        constraint events_hackathons_id_fk
            references hackathons,
    location     varchar   not null,
    start_date   timestamp not null,
    end_date     timestamp not null,
    name         varchar   not null,
    description  varchar   not null
);

alter table events
    owner to postgres;

create table meals
(
    meals        character varying[] not null,
    hackathon_id integer             not null,
    user_id      integer             not null
);

alter table meals
    owner to postgres;

create table hackathon_checkin
(
    time         timestamp not null,
    hackathon_id integer   not null,
    user_id      integer   not null
);

alter table hackathon_checkin
    owner to postgres;

create table event_attendance
(
    time     timestamp not null,
    user_id  integer   not null,
    event_id integer   not null
);

alter table event_attendance
    owner to postgres;

create table hackathon_applications
(
    user_id                   integer             not null,
    hackathon_id              integer             not null,
    why_attend                character varying[] not null,
    what_do_you_want_to_learn character varying[] not null,
    share_info_with_sponsors  boolean             not null,
    application_status        varchar             not null,
    created_time              timestamp           not null,
    status_change_time        timestamp,
    id                        serial
        constraint hackathon_applications_pk
            primary key
);

alter table hackathon_applications
    owner to postgres;

create table education_info
(
    name            varchar   not null,
    major           varchar   not null,
    graduation_date timestamp not null,
    level           varchar,
    user_id         integer   not null
        constraint education_info_pk
            primary key
);

alter table education_info
    owner to postgres;

create table mailing_addresses
(
    country       varchar             not null,
    state         varchar             not null,
    city          varchar             not null,
    postal_code   varchar             not null,
    address_lines character varying[] not null,
    user_id       integer             not null
        constraint mailing_addresses_pk
            primary key
);

alter table mailing_addresses
    owner to postgres;

create table mlh_terms
(
    send_messages   boolean not null,
    share_info      boolean not null,
    code_of_conduct boolean not null,
    user_id         integer not null
);

alter table mlh_terms
    owner to postgres;

