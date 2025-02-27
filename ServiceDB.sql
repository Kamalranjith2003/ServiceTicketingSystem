Create database CustomerServiceDB4;

USE CustomerServiceDB4;

-- Create Users Table (Stores Clients & Vendors)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(50) NOT NULL,
    role ENUM('client', 'vendor') NOT NULL
);

-- Create Tickets Table (Stores Service Requests)
CREATE TABLE tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    vendor_id INT DEFAULT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    urgency ENUM('Low', 'Medium', 'High') DEFAULT 'Medium',
    status ENUM('Pending', 'In Process', 'Resolved') DEFAULT 'Pending',
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_date DATETIME NULL,
    steps_taken TEXT DEFAULT NULL,
    solution_description TEXT DEFAULT NULL,
    FOREIGN KEY (client_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- alter
ALTER TABLE tickets
ADD COLUMN assigned_vendor_id INT;

-- Create Clarifications Table (Stores Vendor Queries to Client)
CREATE TABLE clarifications (
    clarification_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    vendor_id INT NOT NULL,
    question TEXT NOT NULL,
    answer TEXT DEFAULT NULL,
    asked_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    answered_date TIMESTAMP NULL DEFAULT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Create Solutions Table (Stores Solutions for Tickets)
CREATE TABLE solutions (
    solution_id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL,
    vendor_id INT NOT NULL,
    solution_description TEXT NOT NULL,
    solved_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) ON DELETE CASCADE,
    FOREIGN KEY (vendor_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE ticket_solutions (
    solution_id INT AUTO_INCREMENT PRIMARY KEY, 
    ticket_id INT NOT NULL,                     
    solution_description TEXT NOT NULL,         
    steps_taken TEXT,                           
    solved_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) 
);

ALTER TABLE tickets CHANGE COLUMN vendor_id assignedvendor_id INT DEFAULT NULL;

ALTER TABLE tickets MODIFY status ENUM('Pending', 'In Progress', 'Resolved') DEFAULT 'Pending';


DESC users;
desc tickets;
DESC ticket_solutions;
desc solutions;
DESC clarifications;
