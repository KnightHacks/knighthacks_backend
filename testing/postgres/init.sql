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
    id       serial,
    year     integer  not null,
    semester semester not null,
    constraint terms_pk
        primary key (id)
);

create unique index terms_id_uindex
    on terms (id);

create table hackathons
(
    id         serial,
    term_id    serial,
    start_date timestamp not null,
    end_date   timestamp not null,
    constraint hackathons_pk
        primary key (id),
    constraint hackathons_terms_id_fk
        foreign key (term_id) references terms
);

create unique index hackathons_id_uindex
    on hackathons (id);

create unique index hackathons_term_id_uindex
    on hackathons (term_id);

alter table terms
    add constraint terms_hackathons_term_id_fk
        foreign key (id) references hackathons (term_id);

create table pronouns
(
    id         serial,
    subjective varchar not null,
    objective  varchar not null,
    constraint pronouns_pk
        primary key (id)
);

create unique index pronouns_id_uindex
    on pronouns (id);

create table users
(
    id             serial,
    email          varchar not null,
    phone_number   varchar,
    last_name      varchar not null,
    age            integer,
    pronoun_id     integer,
    first_name     varchar not null,
    role           varchar not null,
    oauth_uid      varchar not null,
    oauth_provider varchar not null,
    constraint users_pk
        primary key (id, oauth_uid),
    constraint users_pronouns_id_fk
        foreign key (pronoun_id) references pronouns
);

create unique index users_email_uindex
    on users (email);

create unique index users_phone_number_uindex
    on users (phone_number);

create table hackathon_participants
(
    user_id      integer not null,
    hackathon_id integer not null
);

create table hackathon_sponsors
(
    hackathon_id integer not null,
    sponsor_id   integer not null
);

create table events
(
    id           serial,
    hackathon_id integer   not null,
    location     varchar   not null,
    start_date   timestamp not null,
    end_date     timestamp not null,
    name         varchar   not null,
    description  varchar   not null,
    constraint events_pk
        primary key (id),
    constraint events_hackathons_id_fk
        foreign key (hackathon_id) references hackathons
);


