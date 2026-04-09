CREATE TABLE signals (
    hash TEXT PRIMARY KEY, -- SHA-256 of source text
    title TEXT,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pass_data (
    id INTEGER PRIMARY KEY,
    signal_hash TEXT,
    pass_index INTEGER, -- 0 to 7
    data JSON, -- The full state at that pass
    FOREIGN KEY(signal_hash) REFERENCES signals(hash)
);