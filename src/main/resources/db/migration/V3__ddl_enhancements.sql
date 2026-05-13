--created indexes
CREATE INDEX idx_books_user_id ON books(user_id);
CREATE INDEX idx_books_status ON books(reading_status);
CREATE INDEX idx_sessions_book_id ON reading_sessions(book_id);

-- soft delete support
ALTER TABLE books
ADD COLUMN deleted_at TIMESTAMP DEFAULT NULL;