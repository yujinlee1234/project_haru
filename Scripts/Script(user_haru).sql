select b.*, t.btoday 
from project_haru.board as b 
left join project_haru.board_today as t
on b.bno = t.bno;

select * from project_haru.`user`;

insert into project_haru.`user` values('admin', 'lyj9513@naver.com', 'admin', null, '관리자', null, true, now(), null);
