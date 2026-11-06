CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uucms_id TEXT NOT NULL UNIQUE,
    full_name TEXT NOT NULL,
    class_name TEXT,
    year TEXT,
    department TEXT,
    section TEXT,
    email TEXT,
    phone_number TEXT,
    guardian_name TEXT,
    guardian_number TEXT,
    gender TEXT,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('admin', 'teacher', 'student')),
    approval_status TEXT NOT NULL DEFAULT 'approved' CHECK (approval_status IN ('pending', 'approved', 'rejected')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS attendance (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    subject TEXT NOT NULL,
    month TEXT NOT NULL,
    attended_classes INTEGER NOT NULL DEFAULT 0,
    total_classes INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users (id),
    UNIQUE (user_id, subject, month)
);

CREATE TABLE IF NOT EXISTS timetable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    semester TEXT NOT NULL,
    day TEXT NOT NULL,
    day_order INTEGER NOT NULL,
    period_1 TEXT,
    period_2 TEXT,
    period_3 TEXT,
    period_4 TEXT,
    period_6 TEXT,
    period_7 TEXT,
    UNIQUE (semester, day)
);

CREATE TABLE IF NOT EXISTS department_timetable (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    department TEXT NOT NULL,
    semester TEXT NOT NULL,
    day TEXT NOT NULL,
    day_order INTEGER NOT NULL,
    period_1 TEXT,
    period_2 TEXT,
    period_3 TEXT,
    period_4 TEXT,
    period_6 TEXT,
    period_7 TEXT,
    UNIQUE (department, semester, day)
);

CREATE TABLE IF NOT EXISTS marks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    semester TEXT NOT NULL,
    subject TEXT NOT NULL,
    internal_marks REAL NOT NULL,
    final_marks REAL NOT NULL,
    last_year_cgpa REAL NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    UNIQUE (user_id, semester, subject)
);

CREATE TABLE IF NOT EXISTS fee_payments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    amount INTEGER NOT NULL CHECK (amount > 0),
    note TEXT,
    recorded_by TEXT NOT NULL,
    paid_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS account_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER,
    uucms_id TEXT NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL,
    email TEXT,
    class_name TEXT,
    year TEXT,
    department TEXT,
    section TEXT,
    phone_number TEXT,
    guardian_name TEXT,
    guardian_number TEXT,
    gender TEXT,
    action TEXT NOT NULL CHECK (action IN ('created', 'login', 'approved', 'rejected', 'deleted')),
    occurred_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);
