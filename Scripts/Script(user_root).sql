-- 회원
DROP TABLE IF EXISTS `project_haru`.`user` RESTRICT;

-- 일기
DROP TABLE IF EXISTS `project_haru`.`diary` RESTRICT;

-- 다이어리 게시글
DROP TABLE IF EXISTS `project_haru`.`board` RESTRICT;

-- 다이어리 권한
DROP TABLE IF EXISTS `project_haru`.`diary_auth` RESTRICT;

-- 하루한줄
DROP SCHEMA IF EXISTS `project_haru`;

-- 하루한줄
CREATE SCHEMA `project_haru`;

-- 회원
CREATE TABLE `project_haru`.`user` (
	`uid`       VARCHAR(50)  NOT NULL COMMENT '아이디', -- 아이디
	`umail`     VARCHAR(40)  NOT NULL COMMENT '이메일', -- 이메일
	`upass`     VARCHAR(50)  NOT NULL COMMENT '비밀번호', -- 비밀번호
	`upic`      VARCHAR(255) NULL     COMMENT '프로필사진', -- 프로필사진
	`uname`     VARCHAR(50)  NOT NULL COMMENT '이름', -- 이름
	`ujoin`     VARCHAR(10)  NULL     COMMENT '가입방법', -- 가입방법
	`uadmin`    BOOLEAN      NOT NULL DEFAULT false COMMENT '관리자 여부', -- 관리자 여부
	`ujoindate` TIMESTAMP    NULL     DEFAULT now() COMMENT '가입날짜', -- 가입날짜
	`uexitdate` TIMESTAMP    NULL     COMMENT '탈퇴날짜' -- 탈퇴날짜
)
COMMENT '회원';

-- 회원
ALTER TABLE `project_haru`.`user`
	ADD CONSTRAINT `PK_user` -- 회원 기본키
		PRIMARY KEY (
			`uid` -- 아이디
		);

-- 일기
CREATE TABLE `project_haru`.`diary` (
	`dno`    BIGINT       NOT NULL COMMENT '다이어리 번호', -- 다이어리 번호
	`dtitle` VARCHAR(150) NOT NULL COMMENT '다이어리 타이틀', -- 다이어리 타이틀
	`dpic`   VARCHAR(255) NULL     COMMENT '다이어리 대표사진', -- 다이어리 대표사진
	`ddate`  TIMESTAMP    NULL     DEFAULT now() COMMENT '다이어리 시작날짜', -- 다이어리 시작날짜
	`dopen`  BOOLEAN      NOT NULL COMMENT '다이어리 공개여부' -- 다이어리 공개여부
)
COMMENT '일기';

-- 일기
ALTER TABLE `project_haru`.`diary`
	ADD CONSTRAINT `PK_diary` -- 일기 기본키
		PRIMARY KEY (
			`dno` -- 다이어리 번호
		);

-- 다이어리 게시글
CREATE TABLE `project_haru`.`board` (
	`bno`      BIGINT       NOT NULL COMMENT '게시글 번호', -- 게시글 번호
	`bpic`     VARCHAR(255) NULL     COMMENT '게시글 사진', -- 게시글 사진
	`bcontent` TEXT         NOT NULL COMMENT '게시글 내용', -- 게시글 내용
	`bdate`    TIMESTAMP    NOT NULL DEFAULT now() COMMENT '게시글 등록날짜', -- 게시글 등록날짜
	`bopen`    BOOLEAN      NOT NULL COMMENT '게시글 공개여부', -- 게시글 공개여부
	`bcal`     BOOLEAN      NOT NULL DEFAULT false COMMENT '캘린더 노출여부', -- 캘린더 노출여부
	`dno`      BIGINT       NULL     COMMENT '다이어리 번호' -- 다이어리 번호
)
COMMENT '다이어리 게시글';

-- 다이어리 게시글
ALTER TABLE `project_haru`.`board`
	ADD CONSTRAINT `PK_board` -- 다이어리 게시글 기본키
		PRIMARY KEY (
			`bno` -- 게시글 번호
		);

-- 다이어리 권한
CREATE TABLE `project_haru`.`diary_auth` (
	`uid` VARCHAR(50) NOT NULL COMMENT '아이디', -- 아이디
	`dno` BIGINT      NOT NULL COMMENT '다이어리 번호' -- 다이어리 번호
)
COMMENT '다이어리 권한';

-- 다이어리 게시글
ALTER TABLE `project_haru`.`board`
	ADD CONSTRAINT `FK_diary_TO_board` -- 일기 -> 다이어리 게시글
		FOREIGN KEY (
			`dno` -- 다이어리 번호
		)
		REFERENCES `project_haru`.`diary` ( -- 일기
			`dno` -- 다이어리 번호
		);

-- 다이어리 권한
ALTER TABLE `project_haru`.`diary_auth`
	ADD CONSTRAINT `FK_user_TO_diary_auth` -- 회원 -> 다이어리 권한
		FOREIGN KEY (
			`uid` -- 아이디
		)
		REFERENCES `project_haru`.`user` ( -- 회원
			`uid` -- 아이디
		);

-- 다이어리 권한
ALTER TABLE `project_haru`.`diary_auth`
	ADD CONSTRAINT `FK_diary_TO_diary_auth` -- 일기 -> 다이어리 권한
		FOREIGN KEY (
			`dno` -- 다이어리 번호
		)
		REFERENCES `project_haru`.`diary` ( -- 일기
			`dno` -- 다이어리 번호
		);
		
-- user_haru 
CREATE USER 'user_haru'@'%' ;
UPDATE mysql.user SET Password=PASSWORD('haruharu') WHERE User='user_haru' AND Host='%' ;
GRANT Alter ON project_haru.* TO 'user_haru'@'%' ;
GRANT Create ON project_haru.* TO 'user_haru'@'%' ;
GRANT Create view ON project_haru.* TO 'user_haru'@'%' ;
GRANT Delete ON project_haru.* TO 'user_haru'@'%' ;
GRANT Drop ON project_haru.* TO 'user_haru'@'%' ;
GRANT Grant option ON project_haru.* TO 'user_haru'@'%' ;
GRANT Index ON project_haru.* TO 'user_haru'@'%' ;
GRANT Insert ON project_haru.* TO 'user_haru'@'%' ;
GRANT References ON project_haru.* TO 'user_haru'@'%' ;
GRANT Select ON project_haru.* TO 'user_haru'@'%' ;
GRANT Show view ON project_haru.* TO 'user_haru'@'%' ;
GRANT Trigger ON project_haru.* TO 'user_haru'@'%' ;
GRANT Update ON project_haru.* TO 'user_haru'@'%' ;
FLUSH PRIVILEGES ;

-- -------------------------------------------------------------------------------------INIT schema

		select * from project_haru.`user`;
		delete from project_haru.`user`;
		insert into project_haru.`user` values('admin', 'lyj9513@naver.com', 'admin', null, '관리자',null, true, now(), null);
		
		
-- -------------------------------------------------------------------------------------user
		
		select * from project_haru.diary_auth;
		
-- -------------------------------------------------------------------------------------diary_auth
		
		select * from project_haru.diary;
		insert into project_haru.diary values(null, '관리자 다이어리', null, now(), true, 'admin')
		
		select last_insert_id(dno) from project_haru.diary;
-- -------------------------------------------------------------------------------------diary
		
		select * from project_haru.board;
		select * from project_haru.board_like;
		select * from project_haru.board_scrap;
		select b.bno, b.bpic, b.bcontent, b.bdate, b.bopen, b.bcal, b.dno, t.btoday from project_haru.board as b left join project_haru.board_today as t on b.bno = t.bno;
-- -------------------------------------------------------------------------------------board
		
		
		select count(uid) from project_haru.board_like where bno=0;
		
		select u.uid, u.uadmin, u.upic from project_haru.`user` as u left join project_haru.board_like as l on u.uid = l.uid where bno=0;
		
		select uid, uadmin, upic from project_haru.view_board_like_user where bno = 0;
		
		select b.bno, b.bpic, b.bcontent, b.bdate, b.bopen, b.bcal, b.dno 
		from project_haru.board as b 
		left join project_haru.board_scrap as s on b.bno = s.bno
		where s.uid = 'admin' order by s.stime desc;
		
		select u.uid, u.uadmin, u.upic 
		from project_haru.`user` as u
		left join project_haru.board_scrap as s on u.uid = s.uid 
		where s.bno = 0 order by s.stime desc;
		
		
		
		select d.dno, d.dtitle, d.dpic, d.ddate, d.dopen 
		from project_haru.diary as d 
		left join project_haru.board as b on d.dno = b.dno 
		group by b.bno
		order by b.bdate desc;
		
		select d.* from project_haru.diary as d 
		where dno = (select a.dno from project_haru.diary_auth as a where a.uid='admin');
		
		use project_haru;
		insert into diary(dtitle, dpic, ddate, dopen) values('마이 다이어리', null, now(), true);
		select last_insert_id() from project_haru.diary
		