CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TYPE reading_status_enum AS ENUM (
    'WANT_TO_READ',
    'IN_PROGRESS',
    'COMPLETED',
    'DROPPED'
);

CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    username VARCHAR(100) NOT NULL,

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE books (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    title VARCHAR(200) NOT NULL,

    user_id UUID NOT NULL REFERENCES users (user_id),

    start_date DATE DEFAULT CURRENT_DATE,
    end_date DATE CHECK (end_date >= start_date),

    reading_status reading_status_enum NOT NULL,

    total_pages SMALLINT CHECK (total_pages > 0),
    total_chapters SMALLINT CHECK (total_chapters > 0),

    current_page SMALLINT CHECK (current_page >= 0),
    current_chapter SMALLINT CHECK (current_chapter >= 0),

    progress_percent SMALLINT CHECK (
        progress_percent >= 0
        AND progress_percent <= 100
    ),

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reading_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    book_id UUID NOT NULL
        REFERENCES books (id)
        ON DELETE CASCADE,

    start_time TIMESTAMP,
    end_time TIMESTAMP CHECK (end_time >= start_time),

    session_duration_minutes SMALLINT
        CHECK (session_duration_minutes >= 0),

    pages_read SMALLINT CHECK (pages_read >= 0),

    chapters_read SMALLINT CHECK (chapters_read >= 0),

    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);