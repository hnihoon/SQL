-- commit , rollback �׽�Ʈ
--   �� ���� auto commit ������ �����ؾ��մϴ�.
--   �� ���1) ���� �����⿡ �뼭�� ���� (�����ͺ��̽� �޴� - Ʈ����� ��� - manual commit)
--   �� ���2) ������ �޴� - ���� - ���� - ���� ������ auto commit�� ����
SELECT * FROM tbl#;
DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;

ROLLBACK;		-- DELETE ����� ������ �ǵ�����(���)
SELECT * FROM tbl#;

-- ���� ���� 2��
DELETE FROM tbl# WHERE acol = 'momo';
SELECT * FROM tbl#;
COMMIT;
SELECT * FROM tbl#;
ROLLBACK;
SELECT * FROM tbl#;

-- ���� ���� 3��
INSERT INTO "tbl#"(acol,age) VALUES ('nana',33);
SELECT * FROM tbl#;

-- ���� ���� 4��
INSERT INTO "TBL#" (acol,age) VALUES ('nana22',33);
INSERT INTO "TBL#" (acol,age) VALUES ('����',29);
COMMIT;		--���� COMMIT �Ǵ� rollback �� �� ������ ����� COMMIT
UPDATE "TBL#" SET bcol = 'test' WHERE acol = 'nana22';
DELETE FROM "TBL#" t WHERE acol = 'main22';
ROLLBACK;	--���� commit �Ǵ� rollback �� �� ������ ����� rollback 








