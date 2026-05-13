-- progress_percent change to generated stored column
ALTER TABLE books DROP COLUMN progress_percent;

ALTER TABLE books
ADD COLUMN progress_percent SMALLINT
GENERATED ALWAYS AS (
    CASE
        WHEN total_pages > 0
        THEN LEAST(((current_page * 100) / total_pages), 100)
        ELSE 0
    END
) STORED;

-- create trigger function
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger for books
CREATE TRIGGER trg_books_updated_at
BEFORE UPDATE ON books
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- trigger for users
CREATE TRIGGER trg_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- trigger for reading_sessions
CREATE TRIGGER trg_reading_sessions_updated_at
BEFORE UPDATE ON reading_sessions
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- session_duration_minutes generated column
ALTER TABLE reading_sessions
DROP COLUMN session_duration_minutes;

ALTER TABLE reading_sessions
ADD COLUMN session_duration_minutes SMALLINT
GENERATED ALWAYS AS (
    (EXTRACT(EPOCH FROM (end_time - start_time)) / 60)::SMALLINT
) STORED;

-- constraints
ALTER TABLE books
ADD CONSTRAINT chk_page_within_total
CHECK (
    current_page IS NULL
    OR total_pages IS NULL
    OR current_page <= total_pages
);

ALTER TABLE books
ADD CONSTRAINT chk_chapter_within_total
CHECK (
    current_chapter IS NULL
    OR total_chapters IS NULL
    OR current_chapter <= total_chapters
);

-- remove defaults
ALTER TABLE books
ALTER COLUMN start_date DROP DEFAULT;

ALTER TABLE books
ALTER COLUMN end_date DROP DEFAULT;