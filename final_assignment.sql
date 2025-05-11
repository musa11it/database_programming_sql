-- Create the database
CREATE DATABASE LibraryManagementSystem;

-- Use the created database
USE LibraryManagementSystem;

-- Table for storing Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL,
    birth_date DATE,
    UNIQUE(name) -- Ensure author name is unique
);

-- Table for storing Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(255) NOT NULL,
    publication_year YEAR,
    isbn VARCHAR(13) UNIQUE NOT NULL, -- Unique ISBN for each book
    available_copies INT NOT NULL DEFAULT 1 -- Track available copies
);

-- Table to represent the Many-to-Many relationship between Books and Authors
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Table for storing Members of the library
CREATE TABLE Members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL, -- Unique email for each member
    phone VARCHAR(15),
    join_date DATE DEFAULT CURRENT_DATE
);

-- Table for storing Borrowing Transactions
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE
);

-- Insert sample data into Authors
INSERT INTO Authors (name, birth_date) VALUES
('J.K. Rowling', '1965-07-31'),
('George Orwell', '1903-06-25');

-- Insert sample data into Books
INSERT INTO Books (title, publication_year, isbn, available_copies) VALUES
('Harry Potter and the Sorcerer\'s Stone', 1997, '9780747532743', 3),
('1984', 1949, '9780451524935', 2);

-- Insert sample data into Members
INSERT INTO Members (first_name, last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321');

-- Insert relationships between Books and Authors into Book_Author table
INSERT INTO Book_Author (book_id, author_id) VALUES
(1, 1), -- Harry Potter written by J.K. Rowling
(2, 2); -- 1984 written by George Orwell

-- Insert sample transactions for borrowing books
INSERT INTO Transactions (book_id, member_id, borrow_date) VALUES
(1, 1, '2025-05-01'),
(2, 2, '2025-05-02');
