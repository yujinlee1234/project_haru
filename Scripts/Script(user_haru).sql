select b.*, t.btoday 
from project_haru.board as b 
left join project_haru.board_today as t
on b.bno = t.bno;

select * from project_haru.`user`;

insert into project_haru.`user` values('admin', 'lyj9513@naver.com', 'admin', null, '관리자', null, true, now(), null);

select * from project_haru.diary;
delete from project_haru.diary where dno = 8;

update project_haru.diary set dopen = true where dno = 5;
select * from project_haru.view_board;
select * from project_haru.view_board where bdate = 1497279600000 and dno = 1;
select * from project_haru.view_board where dno = 3 and date(bdate) = '2017-06-14';

select * from project_haru.view_board where dno = 1 and year(bdate) = 2017 and month(bdate) = 4;


select date(bdate) from project_haru.view_board;

update project_haru.board set bpic = null where bno=22;