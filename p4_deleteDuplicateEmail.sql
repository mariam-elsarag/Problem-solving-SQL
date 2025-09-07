/*
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.
 

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

The result format is in the following example.
*/

-- self join solution
delete p1
from Person p1
join Person p2
on p1.email = p2.email
where p1.id > p2.id

-- with temp 
with temp as (
    select id, 
           ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS row_num
    from Person
)
delete from Person
where id in (
    select id from temp where row_num > 1
);
