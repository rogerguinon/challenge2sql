# 24303 DATABASES–LABS

## Challenge2: Database management, querying, and SQL scripting

**Goals:**  
The lab will cover the following aspects:

1. **Import/export data** into DB (Data Manipulation Language – DML)
2. Implement **queries in SQL** (Data Query Language – DQL)
3. Implement **PL/SQL requirements**: Procedures, Triggers, and Events

**Methodology:**  
This challenge is divided into four sessions. The statement of the lab must be read in order, following the instructions given step by step.

### Session 1:

```
● Create new tables and import data. Deliver this part in an SQL file: challenge2-load-data.sql
```

### Session 2:

● Create and deliver a new SQL file called **challenge2-queries.sql** for the queries and write your own queries based on the statements.

### Session 3:

● Continue working on the queries from the previous session (**challenge2-queries.sql**).  
● Start working on the list of new _requirements_ for the database that will consist of creating procedures, trigger, and events structures. You should create an SQL file for each: (**challenge2-req01.sql**, **challenge2-req02.sql[...]challenge2-reqNN.sql**). One for every new requirement.

### Session 4:

● Continue working on the implementation of the new requirements (procedures, triggers, and events as asked).  
● Collect your `.sql` files and prepare your deliverables.  

All the used scripts used to solve whole Challenge 2 in a ZIP file. The ZIP file should be called with the NIA of each member of the group: **Uxxxxxx_Uxxxxxx_Uxxxxxx.zip**.  
**ONLY A MEMBER OF THE GROUP WILL BE RESPONSIBLE FOR RETURNING THE CHALLENGE.**  
All the scripts have to be created and also run over your database instance.  

It is important to follow each point of the submission instructions. Otherwise, the lab will not be properly qualified, that is, it will be evaluated with a 0.  
**Please, before your submission check the following requirements:**

● All your scripts work **BEFORE** your submission.  
● You have defined your tables and fields using the names specified in this document.  
● The file scripts must include the UTF-8 codification.  
● The file scripts must follow the names specified in this document.

---

## Grouping:
The challenge must be developed in teams of the same **three students of Challenge 1**.

---

## LAB Database Server Access:
You will be provided with a database server connection to deploy your database (if you are listed in a LAB Team Group).  
Ensure that you are able to connect from home using UPF’s VPN connection:  
[UPF VPN Connection](https://www.upf.edu/intranet/intern-universitat/connexio-vpn)

---

## Software:
We encourage you to use the **DBeaver** client or **MySQL Workbench**. For **DBeaver**, you can get the **Enterprise Edition** license for one year simply by filling out an easy form on their website using UPF email:  
[DBeaver Academic License](https://dbeaver.com/academic-license)

---

## Doubts:
For any doubts outside LAB hours regarding the challenge, please **contact always both** LAB teachers in your emails, and we will come back to you ASAP:

● raimon.izard@upf.edu  
● guillem.casacuberta@upf.edu  

---

**Note:** The University has provided the required software (DBeaver and MySQL Workbench) to develop this lab, which is properly installed on the computers of the laboratory room classes. You will always have the option of working using the university computers. Furthermore, the professors have provided installation guides and manuals to facilitate the installation on your personal computers and for diverse OS systems (Windows, MacOS, and other Unix-like systems). The PCs from the room 54.004 have direct access to the database server instances without passing through VPN.

---

## Deadline:
**06/12/2024 23:59h CET**

---

# 1. Introduction

In the remote database server, each group should find a database called `PXXX_XX_challenge2_music_festival` (where PXXX is your lab group and XX is your team number).  

This provided database represents a scenario of a music festival’s company organizer. It is fully implemented and populated with data. Here you have the relational model of it:  

**Disclaimer:** The contained information within the database is the result of random content generation. Any resemblance to reality is purely coincidental. In order to solve the queries, do not be guided by your previous musical knowledge or common sense. Expect the unexpected. There may be easter eggs.

---

# 2. New Requirements for the Database (50 points)

First of all, make sure that you already have the currency conversion tables created in your database as is asked in Challenge 2 - Part 1.2 (Insert New Data). They will be necessary for the following steps.  

In this part, you will be asked to develop new database objects: **Functions, Procedures**, **Triggers**, and **Events**.  
For all the following requirements, remember to use:

```sql
DROP db_object IF EXISTS db_object_name;
```

```sql
CREATE db_object IF NOT EXISTS db_object_name ...
```

All database objects should follow this pattern for their names: `reqNN_OBJECT_NAME`.  

For instance, for the requirement 1, it should be: `_req01_currency_rounder_`.

Deliver all needed PL/SQL scripts of every requirement on a new SQL file using the following naming convention: **challenge2-reqNN.sql** _(being NN the number of the requirement)_.  

If the requirement is a procedure or a function, add an example of use/execution in a comment at the end of the `.sql` of the delivered requirement.  

**Note:** Submitted scripts have to be able to be launched several times and deliver always the same final result.

---

## Requirements

**2.1. Requirement 1 (1 point):**  
[Details...]

**2.2. Requirement 2 (4 points):**  
[Details...]

**...**

**2.10. Requirement 10 (5 points):**  
[Details...]

---

# 2.11. Correction Criteria

This part will be evaluated **with 50 points**, on these terms:  

● Each requirement has its own points specified.  
● Each requirement will be evaluated on these terms:  
  ○ **Zero points** if the requirement is not done, has compilation errors, or does not deliver what is asked.  
  ○ **Half** the requirement **points** if it compiles and delivers nearly all of what it is asked.  
  ○ **Full** requirement points if it compiles and delivers all of what it is asked.