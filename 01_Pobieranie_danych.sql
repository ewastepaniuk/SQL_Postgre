/** Klauzula SELECT **/

-- 1. Zapytanie znajdujące wszystkich uczniów
select 
    student_id
    ,name
    ,surname
from students;



-- 2. Zapytanie znajdujące wszystkich nauczycieli
select
    teacher_id
    ,name
from teachers;



-- 3. Zapytanie znajdujące tylko imiona i nazwiska nauczycieli
select
	name
from teachers;



-- 4. Zapytanie znajdujące tylko nazwiska i emaile uczniów
select
	surname
	,email
from students;



/** Klauzula WHERE **/

-- 1. Znajdujące wszystkich uczniów o imieniu zaczynającym się na literę A
select
	student_id
	,name
	,surname
from students
where 
	name like 'A%';



-- 2. Znajdujące nauczycieli o płacy powyżej 1900 PLN
select
	teacher_id
	,name
	,pay
from teachers
where pay > '1900';



-- 3. Znajdujące oceny powyżej 4
select students.student_id, students.name, students.surname, marks.mark
from students
join marks on students.student_id = marks.student_id
where mark > 4
order by student_id;


-- 4. Znajdujące nauczyciela nazywającego się Brajan Kubik (zapisz sobie na kartce id tego nauczyciela)
select
	teacher_id
	,name
from teachers
where name like 'Brajan Kubik';


-- 5. Znajdujące oceny wystawione przez Brajana (skorzystaj z id z poprzedniego punktu — szukane oceny będą miały to właśnie id w polu teacher_id)
with kubik as(
	select
		teacher_id
		,name
	from teachers
	where name like 'Brajan Kubik'
)
select 
	marks.student_id, students.surname, marks.mark, kubik.name
from marks
join students on students.student_id = marks.student_id
join kubik on kubik.teacher_id = marks.teacher_id;


/** Klauzula WHERE **/

-- 1. Zapytanie znajdujące dane ucznia o imieniu Damian i nazwisku Laskowski
select * from students
where
	name = 'Damian' and surname = 'Laskowski';


-- 2. Zapytanie znajdujące oceny Damiana Laskowskiego, które są wyższe niż 3

with laskowski as(
	select * from students
		where
			name = 'Damian' and surname = 'Laskowski')
select students.name, students.surname, marks.mark
from marks

join students on students.student_id = marks.student_id

where mark > 3;



-- 3. Wszystkich uczniów o imionach zaczynających się na D lub B
select * from students
where name like 'D%' or name like 'B%';


/** Klauzula ORDER BY **/

-- 1. Zapytanie znajdujące wszystkie oceny wystawione przez Klarę Dąbkowską, posegregowane od najwyższej
with klara as(
	select teacher_id from teachers
	where name = 'Klara Dąbkowską'
)
select * from marks
where teacher_id = (select * from klara)
order by mark desc; 



-- 2. Zapytanie znajdujące wszystkich uczniów posegregowanych alfabetycznie względem nazwiska
select * from students
order by surname;



-- 3. Zapytanie znajdujące wszystkie oceny otrzymane przez ucznia z emailem bertram.adamiak@yahoo.com, posegregowane od najwyższej
with bertram as
	(
		select 
		student_id, email 
		from students
			where email like 'bertram%'
	)
select marks.student_id, marks.mark, students.email 
from marks
join students on students.student_id = marks.student_id
where marks.student_id = (select student_id from bertram)
;



