-- 하루한줄
DROP SCHEMA IF EXISTS `project_haru`;

-- 하루한줄
CREATE SCHEMA `project_haru`;

-- 일기
CREATE TABLE `project_haru`.`diary` (
	`dno`    BIGINT       NOT null auto_increment COMMENT '다이어리 번호', -- 다이어리 번호
	`dtitle` VARCHAR(150) NOT NULL COMMENT '다이어리 타이틀', -- 다이어리 타이틀
	`dpic`   VARCHAR(255) NULL     COMMENT '다이어리 대표사진', -- 다이어리 대표사진
	`ddate`  TIMESTAMP    NULL     DEFAULT now() COMMENT '다이어리 시작날짜', -- 다이어리 시작날짜
	`dopen`  BOOLEAN      NOT NULL COMMENT '다이어리 공개여부', -- 다이어리 공개여부
	primary key(dno)
)
COMMENT '일기';

-- 일기
ALTER TABLE `project_haru`.`diary`
	ADD CONSTRAINT `PK_diary` -- 일기 기본키
		PRIMARY KEY (
			`dno` -- 다이어리 번호
		);

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

-- 다이어리 게시글
CREATE TABLE `project_haru`.`board` (
	`bno`      BIGINT       NOT null auto_increment COMMENT '게시글 번호', -- 게시글 번호
	`bpic`     VARCHAR(255) NULL     COMMENT '게시글 사진', -- 게시글 사진
	`bcontent` TEXT         NOT NULL COMMENT '게시글 내용', -- 게시글 내용
	`bdate`    TIMESTAMP    NOT NULL DEFAULT now() COMMENT '게시글 등록날짜', -- 게시글 등록날짜
	`bopen`    BOOLEAN      NOT NULL COMMENT '게시글 공개여부', -- 게시글 공개여부
	`bcal`     BOOLEAN      NOT NULL DEFAULT false COMMENT '캘린더 노출여부', -- 캘린더 노출여부
	`dno`      BIGINT       NULL     COMMENT '다이어리 번호', -- 다이어리 번호
	primary key(bno)
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

-- 다이어리 스크랩
CREATE TABLE `project_haru`.`diary_scrap` (
	`uid`    VARCHAR(50) NOT NULL COMMENT '아이디', -- 아이디
	`dno`    BIGINT      NOT NULL COMMENT '다이어리 번호', -- 다이어리 번호
	`dstime` TIMESTAMP   NULL     COMMENT '스크랩 시간' -- 스크랩 시간
)
COMMENT '다이어리 스크랩';

-- 게시글 스크랩
CREATE TABLE `project_haru`.`board_scrap` (
	`uid`   VARCHAR(50) NOT NULL COMMENT '아이디', -- 아이디
	`bno`   BIGINT      NOT NULL COMMENT '게시글 번호', -- 게시글 번호
	`stime` TIMESTAMP   NULL     COMMENT '스크랩시간' -- 스크랩시간
)
COMMENT '게시글 스크랩';

-- 게시글 좋아요
CREATE TABLE `project_haru`.`board_like` (
	`uid`   VARCHAR(50) NOT NULL COMMENT '아이디', -- 아이디
	`bno`   BIGINT      NOT NULL COMMENT '게시글 번호', -- 게시글 번호
	`ltime` TIMESTAMP   NULL     COMMENT '좋아요 시간' -- 좋아요 시간
)
COMMENT '게시글 좋아요';

-- 다이어리 게시글 태그
CREATE TABLE `project_haru`.`board_today` (
	`bno`    BIGINT       NOT NULL COMMENT '게시글 번호', -- 게시글 번호
	`btoday` VARCHAR(100) NULL     COMMENT '게시글 태그' -- 게시글 태그
)
COMMENT '다이어리 게시글 태그';

-- 다이어리 게시글 태그
ALTER TABLE `project_haru`.`board_today`
	ADD CONSTRAINT `PK_board_today` -- 다이어리 게시글 태그 기본키
		PRIMARY KEY (
			`bno` -- 게시글 번호
		);

-- 다이어리 게시글
ALTER TABLE `project_haru`.`board`
	ADD CONSTRAINT `FK_diary_TO_board` -- 일기 -> 다이어리 게시글
		FOREIGN KEY (
			`dno` -- 다이어리 번호
		)
		REFERENCES `project_haru`.`diary` ( -- 일기
			`dno` -- 다이어리 번호
		)on delete cascade;

-- 다이어리 권한
ALTER TABLE `project_haru`.`diary_auth`
	ADD CONSTRAINT `FK_user_TO_diary_auth` -- 회원 -> 다이어리 권한
		FOREIGN KEY (
			`uid` -- 아이디
		)
		REFERENCES `project_haru`.`user` ( -- 회원
			`uid` -- 아이디
		)on delete cascade;

-- 다이어리 권한
ALTER TABLE `project_haru`.`diary_auth`
	ADD CONSTRAINT `FK_diary_TO_diary_auth` -- 일기 -> 다이어리 권한
		FOREIGN KEY (
			`dno` -- 다이어리 번호
		)
		REFERENCES `project_haru`.`diary` ( -- 일기
			`dno` -- 다이어리 번호
		)on delete cascade;

-- 다이어리 스크랩
ALTER TABLE `project_haru`.`diary_scrap`
	ADD CONSTRAINT `FK_user_TO_diary_scrap` -- 회원 -> 다이어리 스크랩
		FOREIGN KEY (
			`uid` -- 아이디
		)
		REFERENCES `project_haru`.`user` ( -- 회원
			`uid` -- 아이디
		)on delete cascade;

-- 다이어리 스크랩
ALTER TABLE `project_haru`.`diary_scrap`
	ADD CONSTRAINT `FK_diary_TO_diary_scrap` -- 일기 -> 다이어리 스크랩
		FOREIGN KEY (
			`dno` -- 다이어리 번호
		)
		REFERENCES `project_haru`.`diary` ( -- 일기
			`dno` -- 다이어리 번호
		)on delete cascade;

-- 게시글 스크랩
ALTER TABLE `project_haru`.`board_scrap`
	ADD CONSTRAINT `FK_user_TO_board_scrap` -- 회원 -> 게시글 스크랩
		FOREIGN KEY (
			`uid` -- 아이디
		)
		REFERENCES `project_haru`.`user` ( -- 회원
			`uid` -- 아이디
		)on delete cascade;

-- 게시글 스크랩
ALTER TABLE `project_haru`.`board_scrap`
	ADD CONSTRAINT `FK_board_TO_board_scrap` -- 다이어리 게시글 -> 게시글 스크랩
		FOREIGN KEY (
			`bno` -- 게시글 번호
		)
		REFERENCES `project_haru`.`board` ( -- 다이어리 게시글
			`bno` -- 게시글 번호
		)on delete cascade;

-- 게시글 좋아요
ALTER TABLE `project_haru`.`board_like`
	ADD CONSTRAINT `FK_user_TO_board_like` -- 회원 -> 게시글 좋아요
		FOREIGN KEY (
			`uid` -- 아이디
		)
		REFERENCES `project_haru`.`user` ( -- 회원
			`uid` -- 아이디
		)on delete cascade;

-- 게시글 좋아요
ALTER TABLE `project_haru`.`board_like`
	ADD CONSTRAINT `FK_board_TO_board_like` -- 다이어리 게시글 -> 게시글 좋아요
		FOREIGN KEY (
			`bno` -- 게시글 번호
		)
		REFERENCES `project_haru`.`board` ( -- 다이어리 게시글
			`bno` -- 게시글 번호
		)on delete cascade;

-- 다이어리 게시글 태그
ALTER TABLE `project_haru`.`board_today`
	ADD CONSTRAINT `FK_board_TO_board_today` -- 다이어리 게시글 -> 다이어리 게시글 태그
		FOREIGN KEY (
			`bno` -- 게시글 번호
		)
		REFERENCES `project_haru`.`board` ( -- 다이어리 게시글
			`bno` -- 게시글 번호
		)on delete cascade;
		
		
		
		
		
		
		