-- Gán quyền CONTROL (toàn quyền) cho Giám đốc và Phó giám đốc
CREATE ROLE [Giám đốc]
GRANT CONTROL TO [Giám đốc]
CREATE ROLE [Phó giám đốc]
GRANT CONTROL TO [Phó giám đốc]

-- Gán các quyền cụ thể cho phòng quản lý nhân sự
CREATE ROLE [Nhân viên quản lý nhân sự]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Luong TO [Nhân viên quản lý nhân sự]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.NhanVien TO [Nhân viên quản lý nhân sự]
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.NhanVien TO [Nhân viên quản lý nhân sự]

-- Gán các quyền cụ thể cho trưởng phòng và phó phòng chung
CREATE ROLE [Trưởng phòng - Phó phòng]
GRANT SELECT ON dbo.NhanVien TO [Trưởng phòng - Phó phòng]
GRANT SELECT, UPDATE ON dbo.Luong TO [Trưởng phòng - Phó phòng]

-- Gán các quyền cụ thể cho nhân viên nói chung
CREATE ROLE [Nhân viên]
GRANT SELECT ON dbo.Luong TO [Nhân viên]
GRANT SELECT ON dbo.NhanVien TO [Nhân viên]

-- Đăng nhập
USE master;
CREATE LOGIN giamdoc WITH PASSWORD = '123456';
CREATE LOGIN phogiamdoc WITH PASSWORD = '123456';

USE QuanLyNhanVien_Prj1;
CREATE USER giamdoc FOR LOGIN giamdoc;
ALTER ROLE [Giám đốc] ADD MEMBER giamdoc;
CREATE USER phogiamdoc FOR LOGIN phogiamdoc;
ALTER ROLE [Phó giám đốc] ADD MEMBER phogiamdoc;
