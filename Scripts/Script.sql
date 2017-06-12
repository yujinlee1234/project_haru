-- 이력서
DROP SCHEMA IF EXISTS `project_introduce`;

-- 이력서
CREATE SCHEMA `project_introduce`;

-- contact
CREATE TABLE `project_introduce`.`contact` (
	`cno`      INT          NOT NULL COMMENT '연락처 번호', -- 연락처 번호
	`cname`    VARCHAR(150) NULL     COMMENT '이름', -- 이름
	`cemail`   VARCHAR(150) NOT NULL COMMENT '이메일', -- 이메일
	`ccontent` TEXT         NULL     COMMENT '메세지' -- 메세지
)
COMMENT 'contact';

-- contact
ALTER TABLE `project_introduce`.`contact`
	ADD CONSTRAINT `PK_contact` -- contact 기본키
		PRIMARY KEY (
			`cno` -- 연락처 번호
		);

ALTER TABLE `project_introduce`.`contact`
	MODIFY COLUMN `cno` INT NOT NULL AUTO_INCREMENT COMMENT '연락처 번호';

-- admin
CREATE TABLE `project_introduce`.`admin` (
	`id`   VARCHAR(50) NOT NULL COMMENT '아이디', -- 아이디
	`pass` VARCHAR(50) NOT NULL COMMENT '비밀번호' -- 비밀번호
)
COMMENT 'admin';

-- admin
ALTER TABLE `project_introduce`.`admin`
	ADD CONSTRAINT `PK_admin` -- admin 기본키
		PRIMARY KEY (
			`id` -- 아이디
		);

-- portfolio
CREATE TABLE `project_introduce`.`portfolio` (
	`pno`     INT          NOT NULL COMMENT '포트폴리오 번호', -- 포트폴리오 번호
	`pimg`    VARCHAR(150) NULL     COMMENT '사진 경로', -- 사진 경로
	`psimple` VARCHAR(150) NULL     COMMENT '포트폴리오 설명' -- 포트폴리오 설명
)
COMMENT 'portfolio';

-- portfolio
ALTER TABLE `project_introduce`.`portfolio`
	ADD CONSTRAINT `PK_portfolio` -- portfolio 기본키
		PRIMARY KEY (
			`pno` -- 포트폴리오 번호
		);

-- portfolio_detail
CREATE TABLE `project_introduce`.`pdetail` (
	`pno`     INT  NOT NULL COMMENT '포트폴리오 번호', -- 포트폴리오 번호
	`pdetail` TEXT NULL     COMMENT '상세 설명' -- 상세 설명
)
COMMENT 'portfolio_detail';

-- portfolio_detail
ALTER TABLE `project_introduce`.`pdetail`
	ADD CONSTRAINT `PK_pdetail` -- portfolio_detail 기본키
		PRIMARY KEY (
			`pno` -- 포트폴리오 번호
		);

-- portfolio_detail
ALTER TABLE `project_introduce`.`pdetail`
	ADD CONSTRAINT `FK_portfolio_TO_pdetail` -- portfolio -> portfolio_detail
		FOREIGN KEY (
			`pno` -- 포트폴리오 번호
		)
		REFERENCES `project_introduce`.`portfolio` ( -- portfolio
			`pno` -- 포트폴리오 번호
		);
		
CREATE USER 'user_introduce'@'%' ;
UPDATE mysql.user SET Password=PASSWORD('yujin') WHERE User='user_introduce' AND Host='%' ;
GRANT Alter ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Create ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Create view ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Delete ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Drop ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Grant option ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Index ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Insert ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT References ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Select ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Show view ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Trigger ON project_introduce.* TO 'user_introduce'@'%' ;
GRANT Update ON project_introduce.* TO 'user_introduce'@'%' ;
FLUSH PRIVILEGES ;
-- ----------------------------------------------------------------------------------------
select * from project_introduce.admin;
insert into project_introduce.admin values('yujin', 'yujin');

