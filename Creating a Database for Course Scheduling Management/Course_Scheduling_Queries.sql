# A list of students who have a scholarship, sorted in ascending order by the value of their scholarship.
SELECT studentID, studentFirst, studentLast, Scholarship
FROM Student
ORDER BY Scholarship;

# A generated list of professors with their calculated salary per course taught, ordered by highest ascending ratio
SELECT c.profID, (p.profSalary / count(c.courseID)) AS [Salary Per Course]
FROM Professor AS p, Course AS c
WHERE p.profID = c.profID
GROUP BY c.ProfID, p.profSalary
ORDER BY "Salary Per Course";

# Generate the total profit of the university, based off of the tuition paid by students, the students scholarship, and the salary paid to professors
SELECT Sum([studentTuition])-Sum([Scholarship])-Sum([profSalary]) AS [Total Profit of the School]
FROM Student, Professor;

# A list of rooms that are being used for more than one course, include building and roomNum 
SELECT Course.courseRoom, Room.building, Room.roomNum
FROM Room INNER JOIN Course ON Room.roomID = Course.courseRoom
WHERE Exists(
	Select Count([Course].[courseRoom])>1 
	From Course);

#List each course by its size, also display the professor’s name, and name of the course
SELECT Count([Registration].[courseID]) AS [Number of People in Course], Course.courseName, Professor.profFirst, Professor.profLast
FROM Professor INNER JOIN (Course INNER JOIN Registration ON Course.courseID = Registration.courseID) ON Professor.profID = Course.profID
GROUP BY Course.courseName, Professor.profFirst, Professor.profLast
ORDER BY Count([Registration].[courseID]);

# A list of open classes with a specific professor 
SELECT profID, courseID, courseName
FROM Course
WHERE ProfID = input;

# List the registration IDs of a given course
SELECT r.regID
FROM Course c, Registration r
WHERE c.courseID = r.courseID AND r.courseID = input;

# Determine which major has the most students
SELECT majorID, count(studentID) as [Number of Students]
FROM Student
GROUP BY majorID
ORDER BY count(studentID) DESC
LIMIT 1;

# List the student ID, first and last name, and major of all students with x years left to graduation, where x is a parameter input by the user of the query
SELECT Student.studentID, Student.studentFirst, Student.studentLast, Student.yearToGrad
FROM Student
Where yearToGrad = inputyear;

# Sort all rooms by building, in descending order by building name
SELECT Room.building, Room.roomID
FROM Room
ORDER BY Room.building DESC;

# Display each course sorted by its professor and its times
SELECT Course.profID, Course.courseTime, Course.courseName
FROM Course
ORDER BY Course.profID, Course.courseTime;
