create type semester as enum ('fall', 'spring', 'summer');

create type subscription_tier as enum ('BRONZE', 'SILVER', 'GOLD', 'PLATINUM');

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

create unique index hackathons_id_uindex
    on hackathons (id);

create unique index hackathons_term_id_uindex
    on hackathons (term_id);

create unique index terms_id_uindex
    on terms (id);

create table pronouns
(
    id         serial
        constraint pronouns_pk
            primary key,
    subjective varchar not null,
    objective  varchar not null
);

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
    constraint users_pk
        primary key (id, oauth_uid)
);

create unique index users_email_uindex
    on users (email);

create unique index users_id_uindex
    on users (id);

create unique index users_phone_number_uindex
    on users (phone_number);

create unique index pronouns_id_uindex
    on pronouns (id);

