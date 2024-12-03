
# 24303 DATABASES – LABS

## Challenge 2: Database management, querying and SQL scripting

### Goals
The lab will cover the following aspects:
1. **Data Manipulation Language (DML):** Import/export data into DB.
2. **Data Query Language (DQL):** Implement queries in SQL.
3. **PL/SQL Requirements:** Create procedures, triggers, and events.

### Methodology
This challenge is divided into **four sessions**. Follow the instructions step by step.

#### Session 1
- Create new tables and import data. Deliver this part in a file: `challenge2-load-data.sql`.

#### Session 2
- Write queries in SQL based on the requirements and deliver in a file: `challenge2-queries.sql`.

#### Session 3
- Continue working on queries (`challenge2-queries.sql`).
- Develop new database objects: procedures, triggers, and events. Create individual SQL files for each:
  - `challenge2-req01.sql`, `challenge2-req02.sql`, … `challenge2-reqNN.sql`.

#### Session 4
- Complete the implementation of new requirements.
- Collect all `.sql` files into a ZIP archive named with the NIA numbers of the team members: `Uxxxxxx_Uxxxxxx_Uxxxxxx.zip`.

### Submission Instructions
To ensure the lab is qualified, verify the following:
- All scripts execute successfully before submission.
- Table and field names adhere to the specification.
- Scripts are UTF-8 encoded.
- Files follow the specified naming convention.

---

## 1. Introduction
Each group has a database named `PXXX_XX_challange2_music_festival`. This database represents a music festival company's operations. Use the provided relational model and avoid relying on musical knowledge or assumptions.

---

## 2. New Requirements for the Database (50 points)

### General Guidelines
1. Ensure the `currency conversion tables` from Challenge 2 - Part 1.2 are present.
2. Use `DROP db_object IF EXISTS` and `CREATE db_object` to define objects.
3. Follow the naming convention: `reqNN_OBJECT_NAME`.

---

### 2.1. Requirement 1 (1 point)
Create a function that rounds a float number to two decimal places if it has more than two decimals.

---

### 2.2. Requirement 2 (4 points)
Create a function that checks if a given currency code exists. Return `TRUE` if it exists, `FALSE` otherwise.

---

### 2.3. Requirement 3 (4 points)
Create a procedure to check if a date and currency code exist in conversion tables. Return `TRUE` or `FALSE` accordingly.

---

### 2.4. Requirement 4 (10 points)
Develop a stored procedure to handle currency conversions involving USD. Parameters include:
- **Input/Output Values:** Origin currency, destination currency, date, amount, and error message.

---

### 2.5. Requirement 5 (8 points)
Create a procedure to insert new conversion rates into the tables for missing days. Ensure consistency in USD conversions.

---

### 2.6. Requirement 6 (2 points)
Automate the execution of the procedure from Requirement 5 using a schedule:
- Example: Group `P201_07` executes at 22:07 (22h for `P201` and 7 for group number).

---

### 2.7. Requirement 7 (3 points)
Create a function to determine the default currency for a person based on their nationality.

---

### 2.8. Requirement 8 (10 points)
Design a solution to track payments for bar and beer sales. Implement a structure for automatic data consistency.

---

### 2.9. Requirement 9 (3 points)
Simulate a scenario where fake data is inserted for a specific artist's song (`Lew Sid`) during festivals.

---

### 2.10. Requirement 10 (5 points)
Create a procedure to fix records where alcohol was sold to minors. Assign these records to specific festivalgoers.

---

### 2.11. Correction Criteria
- Each requirement is evaluated based on completion:
  - **0 Points:** Not done, errors, or incorrect results.
  - **Half Points:** Nearly complete.
  - **Full Points:** Fully complete.

---

### Deadline
**06/12/2024 23:59h CET**

For further details, refer to the [MySQL documentation on procedures](https://dev.mysql.com/doc/refman/8.4/en/create-procedure.html) and other relevant topics.
