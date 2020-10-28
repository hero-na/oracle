DELETE p1
SELECT Id
FROM Person p1
INNER JOIN Person p2 ON p1.Email = pe.Email
WHERE p1.Id > p2.Id