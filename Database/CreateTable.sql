﻿-- 1. Tạo bảng phòng ban
CREATE TABLE PhongBan (
	STT INT IDENTITY(1, 1),
    MaPhongBan AS CONVERT(NVARCHAR(10), N'MPB' + RIGHT('00000' + CAST(STT AS VARCHAR(5)), 5)) PERSISTED PRIMARY KEY,
    TenPhongBan NVARCHAR(225),
    ChiNhanh NVARCHAR(50)
);

-- 2. Tạo bảng nhân viên
CREATE TABLE NhanVien (
	STT INT IDENTITY(1, 1),
    MaNhanVien AS CONVERT(NVARCHAR(10), N'MNV' + RIGHT('000000' + CAST(STT AS VARCHAR(6)), 6)) PERSISTED PRIMARY KEY,
    HoTen NVARCHAR(255),
    NgaySinh DATE,
    TonGiao NVARCHAR(50),
	ChucVu NVARCHAR(50),
	SoDienThoai NVARCHAR(15),
	Email NVARCHAR(255),
    SoCMNDCCCD NVARCHAR(20) UNIQUE,
	DiaChi NVARCHAR(255),
    QueQuan NVARCHAR(255),
    GioiTinh NVARCHAR(10),
    MaPhongBan NVARCHAR(10),
    FOREIGN KEY (MaPhongBan) REFERENCES PhongBan(MaPhongBan)
);

-- 3. Tạo bảng lương
CREATE TABLE Luong (
	STT INT IDENTITY(1, 1),
    MaLuong AS CONVERT(NVARCHAR(10), N'ML' + RIGHT('0000000' + CAST(STT AS VARCHAR(7)), 7)) PERSISTED PRIMARY KEY,
	ThoiGian DATE,
    LuongCoBan DECIMAL(12, 2),
	Thuong DECIMAL(12, 2),
	Phat DECIMAL(12, 2),
	MaNhanVien NVARCHAR(10)
	FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- 4. Tạo bảng tài khoản
CREATE TABLE TaiKhoan (
	MaNhanVien NVARCHAR(10) NOT NULL PRIMARY KEY,
	MatKhau NVARCHAR(20),
	Quyen NVARCHAR(20),
	FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien)
);

-- 5. Tạo bảng lưu thông tin khi bảng nhân viên bị xóa
CREATE TABLE Deleted_NhanVien (
    STT INT IDENTITY(1, 1),
    ThoiGianXoa DATETIME DEFAULT GETDATE(),
    MaNhanVien NVARCHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(255),
    NgaySinh DATE,
    TonGiao NVARCHAR(50),
	ChucVu NVARCHAR(50),
	SoDienThoai NVARCHAR(15),
	Email NVARCHAR(255),
    SoCMNDCCCD NVARCHAR(20) UNIQUE,
	DiaChi NVARCHAR(255),
    QueQuan NVARCHAR(255),
    GioiTinh NVARCHAR(10),
    MaPhongBan NVARCHAR(10)
);

-- 6. Tạo bảng lưu thông tin khi bảng phòng ban bị xóa
CREATE TABLE Deleted_PhongBan (
	STT INT IDENTITY(1, 1),
    MaPhongBan NVARCHAR(10) PRIMARY KEY,
    ThoiGianXoa DATETIME DEFAULT GETDATE(),
    TenPhongBan NVARCHAR(225),
    ChiNhanh NVARCHAR(50)
);

-- 7. Tạo bảng lưu thông tin khi bảng lương bị xóa
CREATE TABLE Deleted_Luong (
    STT INT IDENTITY(1, 1),
    ThoiGianXoa DATETIME DEFAULT GETDATE(),
    MaLuong NVARCHAR(10) PRIMARY KEY,
    ThoiGian DATE,
    LuongCoBan DECIMAL(12, 2),
	Thuong DECIMAL(12, 2),
	Phat DECIMAL(12, 2),
	MaNhanVien NVARCHAR(10)
    
);

--8. Tạo bảng lưu thông tin khi bảng tài khoản bị xóa
CREATE TABLE Deleted_TaiKhoan (
    STT INT IDENTITY(1, 1),
    ThoiGianXoa DATETIME DEFAULT GETDATE(),
	MaNhanVien NVARCHAR(10) PRIMARY KEY,
	MatKhau NVARCHAR(20),
	Quyen NVARCHAR(20),
);

-- Sinh dữ liệu 
INSERT INTO PhongBan (TenPhongBan, ChiNhanh)
VALUES
    (N'Phòng Quản Lý', N'Chi Nhánh 1'), 
    (N'Phòng Kinh Doanh', N'Chi Nhánh 1'),
    (N'Phòng Sản Xuất', N'Chi Nhánh 1'),
	(N'Phòng Nhân Sự', N'Chi Nhánh 1'),
    (N'Phòng Kỹ Thuật', N'Chi Nhánh 1'),
	(N'Phòng Kế Toán', N'Chi Nhánh 1'),

	(N'Phòng Quản Lý', N'Chi Nhánh 2'),
	(N'Phòng Kinh Doanh', N'Chi Nhánh 2'),
    (N'Phòng Sản Xuất', N'Chi Nhánh 2'),
    (N'Phòng Nhân Sự', N'Chi Nhánh 2'),
    (N'Phòng Kỹ Thuật', N'Chi Nhánh 2'),
	(N'Phòng Kế Toán', N'Chi Nhánh 2');

INSERT INTO NhanVien (HoTen, NgaySinh, TonGiao, ChucVu, SoDienThoai, Email, SoCMNDCCCD, DiaChi, QueQuan, GioiTinh, MaPhongBan)
VALUES    
	(N'Trần Thị Mỹ', N'1992-04-05', N'Phật Giáo', N'Giám đốc', N'0123456717', N'my@gmail.com', N'087654321987', N'789 Hoàng Diệu, Quán Thánh, Hà Nội', N'An Giang', N'Nữ', N'MPB00001'),
    (N'Nguyễn Văn Khoa', N'1987-09-20', N'Thiên Chúa Giáo', N'Phó giám đốc', N'0123456718', N'khoa@gmail.com', N'021654987321', N'12 Nguyễn Trãi, Thanh Xuân, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00001'),
    (N'Lê Thị Thu', N'1995-12-10', N'Không', N'Phó giám đốc', N'0123456719', N'thu@gmail.com', N'089321654789', N'56 Lê Thường Kiệt, Hoàn Kiếm, Hà Nội', N'Hà Nội', N'Nữ', N'MPB00001'),
	(N'Đinh Văn Hòa', N'1988-04-18', N'Thiên Chúa Giáo', N'Trưởng phòng kinh doanh', N'0123456783', N'dinhhoa@gmail.com', N'321654987321', N'123 Lê Duẩn, Hai Bà Trưng, Hà Nội', N'Tiền Giang', N'Nam', N'MPB00002'),
	(N'Lý Thị Phương', N'1991-07-30', N'Không', N'Phó phòng kinh doanh', N'0123456784', N'lyphuong@gmail.com', N'054789321654', N'456 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nữ', N'MPB00002'),
    
	(N'Hoàng Văn Giang', N'1987-03-12', N'Phật Giáo', N'Nhân viên bán hàng', N'0123456785', N'hoanggiang@gmail.com', N'987321654987', N'789 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00002'),
    (N'Trần Văn Hùng', N'1993-09-05', N'Thiên Chúa Giáo', N'Nhân viên bán hàng', N'0123456786', N'vanhung@gmail.com', N'047258369147', N'1 Hoàng Cầu, Đống Đa, Hà Nội', N'Quảng Trị', N'Nam', N'MPB00002'),
    (N'Nguyễn Thị Thảo', N'1986-12-22', N'Không', N'Nhân viên bán hàng', N'0123456787', N'thao@gmail.com', N'058369147258', N'56 Lê Ngọc Hân, Hai Bà Trưng, Hà Nội', N'Bình Thuận', N'Nữ', N'MPB00002'),
    (N'Võ Văn Khánh', N'1994-06-17', N'Phật Giáo', N'Nhân viên Marketing', N'0123456788', N'vokhanh@gmail.com', N'069147258369', N'789 Cầu Giấy, Cầu Giấy, Hà Nội', N'Bình Định', N'Nam', N'MPB00002'),
    (N'Phan Thị Linh', N'1989-01-08', N'Thiên Chúa Giáo', N'Nhân viên Marketing', N'0123456799', N'linh@gmail.com', N'654123987654', N'45 Nguyễn Khuyến, Ba Đình, Hà Nội', N'Long An', N'Nữ', N'MPB00002'),

    (N'Đỗ Văn Minh', N'1990-04-02', N'Không', N'Nhân viên Marketing', N'0123456701', N'minh@gmail.com', N'987456321987', N'123 Trần Phú, Hoàn Kiếm, Hà Nội', N'Hưng Yên', N'Nam', N'MPB00002'),
    (N'Bùi Thị Ngọc', N'1995-08-27', N'Phật Giáo', N'Trưởng phòng sản xuất', N'0123456702', N'ngoc@gmail.com', N'321987654321', N'789 Kim Mã, Ba Đình, Hà Nội', N'An Giang', N'Nữ', N'MPB00003'),
    (N'Lê Văn Phúc', N'1988-02-10', N'Thiên Chúa Giáo', N'Phó phòng sản xuất', N'0123456703', N'phuc@gmail.com', N'789321654789', N'56 Bà Triệu, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nam', N'MPB00003'),
    (N'Nguyễn Thị Quỳnh', N'1992-05-15', N'Không', N'Nhân viên sản xuất', N'0123456704', N'quynh@gmail.com', N'147369258147', N'4 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nữ', N'MPB00003'),
    (N'Hồ Văn Đức', N'1987-09-20', N'Phật Giáo', N'Nhân viên sản xuất', N'0123456705', N'duc@gmail.com', N'258147369258', N'12 Hoàng Cầu, Đống Đa, Hà Nội', N'Hà Nội', N'Nam', N'MPB00003'),

    (N'Trần Thị Sương', N'1993-01-12', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0123456706', N'suong@gmail.com', N'369258147369', N'56 Cầu Giấy, Cầu Giấy, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00003'),
    (N'Nguyễn Văn Tuấn', N'1986-04-25', N'Không', N'Nhân viên sản xuất', N'0123456707', N'tuan@gmail.com', N'654321987654', N'789 Bà Triệu, Hoàn Kiếm, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00003'),
    (N'Lê Thị Uyên', N'1994-10-18', N'Phật Giáo', N'Nhân viên sản xuất', N'0123456708', N'uyen@gmail.com', N'987654321987', N'45 Lê Thánh Tông, Hoàn Kiếm, Hà Nội', N'Bình Định', N'Nữ', N'MPB00003'),
    (N'Phạm Văn Việt', N'1989-03-30', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0123456709', N'viet@gmail.com', N'023654987321', N'789 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Tiền Giang', N'Nam', N'MPB00003'),
    (N'Nguyễn Thị Xuân', N'1991-07-15', N'Không', N'Nhân viên sản xuất', N'0123456710', N'xuan@gmail.com', N'089123456789', N'56 Trần Phú, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nữ', N'MPB00003'),

    (N'Vũ Văn Ý', N'1995-02-28', N'Phật Giáo', N'Nhân viên sản xuất', N'0123456711', N'vy@gmail.com', N'456789321456', N'123 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00003'),
    (N'Trần Thị Khánh Chi', N'1988-06-10', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0123456712', N'khanhchi@gmail.com', N'087321654987', N'70 Kim Mã, Ba Đình, Hà Nội', N'Quảng Trị', N'Nữ', N'MPB00003'),
    (N'Lý Văn Long', N'1993-11-05', N'Không', N'Trưởng phòng nhân sự', N'0123456713', N'lylong@gmail.com', N'147258369147', N'56 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bình Thuận', N'Nam', N'MPB00004'),
    (N'Hoàng Thị Yến', N'1986-04-20', N'Phật Giáo', N'Phó phòng nhân sự', N'0123456714', N'yen@gmail.com', N'258369147258', N'789 Lê Duẩn, Hai Bà Trưng, Hà Nội', N'Bình Định', N'Nữ', N'MPB00004'),
    (N'Nguyễn Văn Zí', N'1994-09-15', N'Thiên Chúa Giáo', N'Nhân viên nhân sự', N'0123456715', N'zi@gmail.com', N'369147258369', N'13 Trần Phú, Hoàn Kiếm, Hà Nội', N'Long An', N'Nam', N'MPB00004'),

    (N'Đỗ Thị Xinh', N'1989-12-22', N'Không', N'Nhân viên nhân sự', N'0123456716', N'xinh@gmail.com', N'654789321654', N'456 Kim Mã, Ba Đình, Hà Nội', N'Hưng Yên', N'Nữ', N'MPB00004'),
	(N'Trần Văn Bình', N'1988-02-28', N'Phật Giáo', N'Trưởng phòng kỹ thuật', N'0123456720', N'binh@gmail.com', N'147369253147', N'79 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00005'),
	(N'Trần Văn Anh', N'1990-05-15', N'Phật Giáo', N'Phó phòng kỹ thuật', N'0124537893', N'van.anh@gmail.com', N'123467890125', N'13 Lê Lợi, Ba Đình, Hà Nội', N'Hà Nội', N'Nam', N'MPB00005'),
	(N'Nguyễn Thị Bảo', N'1985-08-20', N'Thiên Chúa Giáo', N'Nhân viên kỹ thuật', N'0124568073', N'nguyen.bao@gmail.com', N'987543210986', N'53 Hoàng Diệu, Quán Thánh, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00005'),
    (N'Nguyễn Văn Hưng', N'1990-05-15', N'Phật Giáo', N'Nhân viên kỹ thuật', N'0901234567', N'vanhungnguyen@yahoo.com', N'033147369258', N'1 Lê Lợi, Ba Đình, Hà Nội', N'Hà Nội', N'Nam', N'MPB00005'),
    
	(N'Trần Thị Quỳnh', N'1985-08-20', N'Thiên Chúa Giáo', N'Nhân viên kỹ thuật', N'0912345678', N'quynhthi@yahoo.com', N'033987321654', N'55 Hoàng Diệu, Quán Thánh, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00005'),
	(N'Nguyễn Văn Anh', N'1990-05-15', N'Phật Giáo', N'Trưởng phòng kế toán', N'0123456789', N'nguyenvananh@gmail.com', N'123456789012', N'12 Lê Lợi, Ba Đình, Hà Nội', N'Hà Nội', N'Nam', N'MPB00006'),
	(N'Trần Thị Bích', N'1985-08-20', N'Thiên Chúa Giáo', N'Phó phòng kế toán', N'0123456780', N'tranbich@gmail.com', N'987654321098', N'56 Hoàng Diệu, Quán Thánh, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00006'),
	(N'Lê Hoàng Cường', N'1995-02-10', N'Không', N'Nhân viên kế toán', N'0123456781', N'hoangcuong@gmail.com', N'456789123456', N'789 Nguyễn Trãi, Thanh Xuân, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00006'),
    (N'Phạm Thị Đông', N'1992-11-25', N'Phật Giáo', N'Nhân viên kế toán', N'0123456782', N'phamdong@gmail.com', N'789123456789', N'45 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Thái Bình', N'Nữ', N'MPB00006'),

    (N'Lê Hoàng Dũng', N'1995-02-10', N'Không', N'Giám đốc', N'0923456789', N'dungle@yahoo.com', N'033678912345', N'78 Nguyễn Trãi, Thanh Xuân, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00007'),
    (N'Phạm Thị Diễm', N'1992-11-25', N'Phật Giáo', N'Phó giám đốc', N'0934567890', N'diempham@yahoo.com', N'033321697987', N'50 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Thái Bình', N'Nữ', N'MPB00007'),
    (N'Đinh Văn Huy', N'1988-04-18', N'Thiên Chúa Giáo', N'Phó giám đốc', N'0945678901', N'huydinh@yahoo.com', N'033654321987', N'12 Lê Duẩn, Hai Bà Trưng, Hà Nội', N'Tiền Giang', N'Nam', N'MPB00007'),
    (N'Lý Thị Mai', N'1991-07-30', N'Không', N'Trưởng phòng kinh doanh', N'0956789012', N'maily@yahoo.com', N'033987686321', N'45 Lý Thường Kiệt, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nữ', N'MPB00008'),
    (N'Hoàng Văn Nam', N'1987-03-12', N'Phật Giáo', N'Nhân viên bán hàng', N'0967890123', N'namhoang@yahoo.com', N'033258147369', N'7 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00008'),

    (N'Trần Thị Ngân', N'1993-09-05', N'Thiên Chúa Giáo', N'Phó phòng kinh doanh', N'0978901234', N'ngan@yahoo.com', N'036369147258', N'120 Hoàng Cầu, Đống Đa, Hà Nội', N'Quảng Trị', N'Nữ', N'MPB00008'),
    (N'Nguyễn Thị Thủy', N'1986-12-22', N'Không', N'Nhân viên bán hàng', N'0989012345', N'thuy@yahoo.com', N'033147258369', N'5 Lê Ngọc Hân, Hai Bà Trưng, Hà Nội', N'Bình Thuận', N'Nữ', N'MPB00008'),
    (N'Võ Văn Hải', N'1994-06-17', N'Phật Giáo', N'Nhân viên bán hàng', N'0911234567', N'haivovan@yahoo.com', N'035369147258', N'39 Cầu Giấy, Cầu Giấy, Hà Nội', N'Bình Định', N'Nam', N'MPB00008'),
    (N'Phan Thị Lan', N'1989-01-08', N'Thiên Chúa Giáo', N'Nhân viên Marketing', N'0922345678', N'lanthi@yahoo.com', N'033321654987', N'25 Nguyễn Khuyến, Ba Đình, Hà Nội', N'Long An', N'Nữ', N'MPB00008'),
    (N'Đỗ Văn Huyền', N'1990-04-02', N'Không', N'Nhân viên Marketing', N'0953456789', N'huyen@yahoo.com', N'033657621987', N'31 Trần Phú, Hoàn Kiếm, Hà Nội', N'Hưng Yên', N'Nữ', N'MPB00008'),

    (N'Bùi Thị An', N'1995-08-27', N'Phật Giáo', N'Nhân viên Marketing', N'0834567890', N'buithian@yahoo.com', N'033987687321', N'293 Kim Mã, Ba Đình, Hà Nội', N'An Giang', N'Nữ', N'MPB00008'),
    (N'Lê Văn Phương', N'1988-02-10', N'Thiên Chúa Giáo', N'Trưởng phòng sản xuất', N'0645678901', N'phuong@yahoo.com', N'033369258147', N'46 Bà Triệu, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nam', N'MPB00009'),
    (N'Nguyễn Thị Trang', N'1992-05-15', N'Không', N'Phó phòng sản xuất', N'0456789012', N'trangthi@yahoo.com', N'033147364258', N'15 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nữ', N'MPB00009'),
    (N'Hồ Văn An', N'1987-09-20', N'Phật Giáo', N'Nhân viên sản xuất', N'0367890123', N'anhv@yahoo.com', N'033258657369', N'25 Hoàng Cầu, Đống Đa, Hà Nội', N'Hà Nội', N'Nam', N'MPB00009'),
    (N'Trần Thị Bảo Hương', N'1993-01-12', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0278901234', N'huongtranbao@yahoo.com', N'033369147258', N'50 Cầu Giấy, Cầu Giấy, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00009'),

    (N'Nguyễn Văn Thành', N'1986-04-25', N'Không', N'Nhân viên sản xuất', N'0999012345', N'thanh@yahoo.com', N'033657721987', N'189 Bà Triệu, Hoàn Kiếm, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00009'),
    (N'Lê Thị Mạnh', N'1994-10-18', N'Phật Giáo', N'Nhân viên sản xuất', N'0921234567', N'manh@yahoo.com', N'033987688321', N'41 Lê Thánh Tông, Hoàn Kiếm, Hà Nội', N'Bình Định', N'Nữ', N'MPB00009'),
    (N'Nguyễn Văn Nghĩa', N'1989-03-30', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0932345678', N'nghia@yahoo.com', N'033321698987', N'729 Hoàng Diệu, Quán Thánh, Hà Nội', N'Tiền Giang', N'Nam', N'MPB00009'),
    (N'Vũ Thị Dung', N'1991-07-15', N'Không', N'Nhân viên sản xuất', N'0943456789', N'dungvu@yahoo.com', N'033987689321', N'29 Trần Phú, Hoàn Kiếm, Hà Nội', N'Khánh Hòa', N'Nữ', N'MPB00009'),
    (N'Trần Đức Huy', N'1995-02-28', N'Phật Giáo', N'Nhân viên sản xuất', N'0734567890', N'huyduc@yahoo.com', N'034369147258', N'120 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00009'),

    (N'Nguyễn Văn Hải', N'1988-06-10', N'Thiên Chúa Giáo', N'Nhân viên sản xuất', N'0545678901', N'hai@yahoo.com', N'032147258369', N'120 Kim Mã, Ba Đình, Hà Nội', N'Quảng Trị', N'Nam', N'MPB00009'),
    (N'Lê Thị An', N'1993-11-05', N'Không', N'Nhân viên sản xuất', N'0969012345', N'anle@yahoo.com', N'033321699987', N'27 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bình Thuận', N'Nữ', N'MPB00009'),
    (N'Trần Thị Lan', N'1992-04-05', N'Phật Giáo', N'Trưởng phòng nhân sự', N'0909123456', N'lantran@yahoo.com', N'033368258147', N'74 Kim Mã, Ba Đình, Hà Nội', N'Hưng Yên', N'Nữ', N'MPB00010'),
    (N'Nguyễn Văn Bách', N'1987-09-20', N'Thiên Chúa Giáo', N'Phó phòng nhân sự', N'0908234567', N'bachnguyen@yahoo.com', N'033455123789', N'22 Nguyễn Trãi, Thanh Xuân, Hà Nội', N'Quảng Nam', N'Nam', N'MPB00010'),
    (N'Lê Thị Trang', N'1995-12-10', N'Không', N'Nhân viên nhân sự', N'0907345678', N'trangle@yahoo.com', N'033489456123', N'48 Lê Thường Kiệt, Hoàn Kiếm, Hà Nội', N'Hà Nội', N'Nữ', N'MPB00010'),

    (N'Trần Văn Minh', N'1988-02-28', N'Phật Giáo', N'Nhân viên nhân sự', N'0906456789', N'minhtran@yahoo.com', N'033143789456', N'29 Trần Hưng Đạo, Ba Đình, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nam', N'MPB00010'),
    (N'Nguyễn Thị Quỳnh Anh', N'1994-09-15', N'Thiên Chúa Giáo', N'Trưởng phòng kỹ thuật', N'0905567890', N'quynhanh@yahoo.com', N'033456123789', N'140 Trần Phú, Hoàn Kiếm, Hà Nội', N'Long An', N'Nữ', N'MPB00011'),
    (N'Hồ Văn Lâm', N'1989-12-22', N'Không', N'Phó phòng kỹ thuật', N'0904678901', N'lam@yahoo.com', N'033589456123', N'17 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Tiền Giang', N'Nam', N'MPB00011'),
    (N'Nguyễn Văn Nam', N'1991-04-25', N'Phật Giáo', N'Nhân viên kỹ thuật', N'0903789012', N'nam@yahoo.com', N'033133789456', N'46 Hoàng Cầu, Đống Đa, Hà Nội', N'Khánh Hòa', N'Nam', N'MPB00011'),
    (N'Lê Thị Diễm', N'1986-09-20', N'Thiên Chúa Giáo', N'Nhân viên kỹ thuật', N'0902890123', N'diem@yahoo.com', N'033457123789', N'42 Cầu Giấy, Cầu Giấy, Hà Nội', N'Quảng Trị', N'Nữ', N'MPB00011'),

    (N'Hoàng Văn Khánh', N'1993-02-10', N'Không', N'Nhân viên kỹ thuật', N'0901901234', N'khanh@yahoo.com', N'033689456123', N'39 Bà Triệu, Hoàn Kiếm, Hà Nội', N'Bình Định', N'Nam', N'MPB00011'),
    (N'Trần Thị Quỳnh Trang', N'1988-07-30', N'Phật Giáo', N'Trưởng phòng kế toán', N'0901012345', N'trangtran@yahoo.com', N'033123789456', N'24 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Bà Rịa - Vũng Tàu', N'Nữ', N'MPB00012'),
    (N'Nguyễn Văn Hùng', N'1993-09-05', N'Thiên Chúa Giáo', N'Phó phòng kế toán', N'0902123456', N'hungnv@yahoo.com', N'033458123789', N'67 Kim Mã, Ba Đình, Hà Nội', N'An Giang', N'Nam', N'MPB00012'),
    (N'Phan Thị Hương', N'1986-12-22', N'Không', N'Nhân viên kế toán', N'0903234567', N'huongphan@yahoo.com', N'033789456123', N'167 Hai Bà Trưng, Hoàn Kiếm, Hà Nội', N'Đồng Nai', N'Nữ', N'MPB00012'),
    (N'Võ Văn Bách', N'1994-06-17', N'Phật Giáo', N'Nhân viên kế toán', N'0904345678', N'bachvovan@yahoo.com', N'033113789456', N'456 Lê Lai, Hoàn Kiếm, Hà Nội', N'Hải Phòng', N'Nam', N'MPB00012');

INSERT INTO Luong (ThoiGian, LuongCoBan, Thuong, Phat, MaNhanVien)
VALUES
    ('2023-10-01', 85000000.00, 10000000.00, 100000.00, 'MNV000001'),
    ('2023-10-01', 75000000.00, 10000000.00, 150000.00, 'MNV000002'),
    ('2023-10-01', 75000000.00, 10000000.00, 150000.00, 'MNV000003'),
    ('2023-10-01', 55000000.00, 5300000.00, 1650000.00, 'MNV000004'),
    ('2023-10-01', 45000000.00, 5400000.00, 1700000.00, 'MNV000005'),
    ('2023-10-01', 20000000.00, 5500000.00, 1750000.00, 'MNV000006'),
    ('2023-10-01', 20000000.00, 5600000.00, 1800000.00, 'MNV000007'),
    ('2023-10-01', 20000000.00, 5700000.00, 1850000.00, 'MNV000008'),
    ('2023-10-01', 20000000.00, 5800000.00, 1900000.00, 'MNV000009'),
    ('2023-10-01', 20000000.00, 5900000.00, 1950000.00, 'MNV000010'),
    ('2023-10-01', 20000000.00, 6000000.00, 2000000.00, 'MNV000011'),
    ('2023-10-01', 55000000.00, 6100000.00, 2050000.00, 'MNV000012'),
    ('2023-10-01', 45000000.00, 6200000.00, 2100000.00, 'MNV000013'),
    ('2023-10-01', 20000000.00, 6300000.00, 2150000.00, 'MNV000014'),
    ('2023-10-01', 20000000.00, 6400000.00, 2200000.00, 'MNV000015'),
    ('2023-10-01', 20000000.00, 6500000.00, 2250000.00, 'MNV000016'),
    ('2023-10-01', 20000000.00, 6600000.00, 2300000.00, 'MNV000017'),
    ('2023-10-01', 20000000.00, 6700000.00, 2350000.00, 'MNV000018'),
    ('2023-10-01', 20000000.00, 6800000.00, 2400000.00, 'MNV000019'),
    ('2023-10-01', 20000000.00, 6900000.00, 2450000.00, 'MNV000020'),
    ('2023-10-01', 20000000.00, 7000000.00, 2500000.00, 'MNV000021'),
    ('2023-10-01', 20000000.00, 7100000.00, 2550000.00, 'MNV000022'),
    ('2023-10-01', 55000000.00, 7200000.00, 2600000.00, 'MNV000023'),
    ('2023-10-01', 45000000.00, 7300000.00, 2650000.00, 'MNV000024'),
    ('2023-10-01', 20000000.00, 7400000.00, 2700000.00, 'MNV000025'),
    ('2023-10-01', 20000000.00, 7500000.00, 2750000.00, 'MNV000026'),
    ('2023-10-01', 55000000.00, 7600000.00, 2800000.00, 'MNV000027'),
    ('2023-10-01', 45000000.00, 7700000.00, 2850000.00, 'MNV000028'),
    ('2023-10-01', 20000000.00, 7800000.00, 2900000.00, 'MNV000029'),
    ('2023-10-01', 20000000.00, 7900000.00, 2950000.00, 'MNV000030'),
    ('2023-10-01', 20000000.00, 8000000.00, 3000000.00, 'MNV000031'),
    ('2023-10-01', 55000000.00, 8100000.00, 3050000.00, 'MNV000032'),
    ('2023-10-01', 45000000.00, 8200000.00, 3100000.00, 'MNV000033'),
    ('2023-10-01', 20000000.00, 8300000.00, 3150000.00, 'MNV000034'),
    ('2023-10-01', 20000000.00, 8400000.00, 3200000.00, 'MNV000035'),
    ('2023-10-01', 85000000.00, 8500000.00, 3250000.00, 'MNV000036'),
    ('2023-10-01', 75000000.00, 8600000.00, 3300000.00, 'MNV000037'),
    ('2023-10-01', 75000000.00, 8700000.00, 3350000.00, 'MNV000038'),
    ('2023-10-01', 55000000.00, 8800000.00, 3400000.00, 'MNV000039'),
    ('2023-10-01', 45000000.00, 8900000.00, 3450000.00, 'MNV000040'),
    ('2023-10-01', 20000000.00, 9000000.00, 3500000.00, 'MNV000041'),
    ('2023-10-01', 20000000.00, 9100000.00, 3550000.00, 'MNV000042'),
    ('2023-10-01', 20000000.00, 9200000.00, 3600000.00, 'MNV000043'),
    ('2023-10-01', 20000000.00, 9300000.00, 3650000.00, 'MNV000044'),
    ('2023-10-01', 20000000.00, 9400000.00, 3700000.00, 'MNV000045'),
    ('2023-10-01', 20000000.00, 9500000.00, 3750000.00, 'MNV000046'),
    ('2023-10-01', 55000000.00, 9600000.00, 3800000.00, 'MNV000047'),
    ('2023-10-01', 45000000.00, 9700000.00, 3850000.00, 'MNV000048'),
    ('2023-10-01', 20000000.00, 9800000.00, 3900000.00, 'MNV000049'),
    ('2023-10-01', 20000000.00, 9900000.00, 3950000.00, 'MNV000050'),
    ('2023-10-01', 20000000.00, 10000000.00, 4000000.00, 'MNV000051'),
    ('2023-10-01', 20000000.00, 10050000.00, 4050000.00, 'MNV000052'),
    ('2023-10-01', 20000000.00, 10100000.00, 4100000.00, 'MNV000053'),
    ('2023-10-01', 20000000.00, 10150000.00, 4150000.00, 'MNV000054'),
    ('2023-10-01', 20000000.00, 10200000.00, 4200000.00, 'MNV000055'),
    ('2023-10-01', 20000000.00, 10250000.00, 4250000.00, 'MNV000056'),
    ('2023-10-01', 20000000.00, 10300000.00, 4300000.00, 'MNV000057'),
    ('2023-10-01', 55000000.00, 10350000.00, 4350000.00, 'MNV000058'),
    ('2023-10-01', 45000000.00, 10400000.00, 4400000.00, 'MNV000059'),
    ('2023-10-01', 20000000.00, 10450000.00, 4450000.00, 'MNV000060'),
    ('2023-10-01', 20000000.00, 10500000.00, 4500000.00, 'MNV000061'),
    ('2023-10-01', 55000000.00, 10550000.00, 4550000.00, 'MNV000062'),
    ('2023-10-01', 45000000.00, 10600000.00, 4600000.00, 'MNV000063'),
    ('2023-10-01', 20000000.00, 10650000.00, 4650000.00, 'MNV000064'),
    ('2023-10-01', 20000000.00, 10700000.00, 4700000.00, 'MNV000065'),
    ('2023-10-01', 20000000.00, 10750000.00, 4750000.00, 'MNV000066'),
    ('2023-10-01', 55000000.00, 10800000.00, 4800000.00, 'MNV000067'),
    ('2023-10-01', 45000000.00, 10850000.00, 4850000.00, 'MNV000068'),
    ('2023-10-01', 20000000.00, 10900000.00, 4900000.00, 'MNV000069'),
    ('2023-10-01', 20000000.00, 10950000.00, 4950000.00, 'MNV000070'),

	('2023-11-01', 85000000.00, 10000000.00, 100000.00, 'MNV000001'),
    ('2023-11-01', 75000000.00, 10000000.00, 150000.00, 'MNV000002'),
    ('2023-11-01', 75000000.00, 10000000.00, 150000.00, 'MNV000003'),
    ('2023-11-01', 55000000.00, 5300000.00, 1650000.00, 'MNV000004'),
    ('2023-11-01', 45000000.00, 5400000.00, 1700000.00, 'MNV000005'),
    ('2023-11-01', 20000000.00, 5500000.00, 1750000.00, 'MNV000006'),
    ('2023-11-01', 20000000.00, 5600000.00, 1800000.00, 'MNV000007'),
    ('2023-11-01', 20000000.00, 5700000.00, 1850000.00, 'MNV000008'),
    ('2023-11-01', 20000000.00, 5800000.00, 1900000.00, 'MNV000009'),
    ('2023-11-01', 20000000.00, 5900000.00, 1950000.00, 'MNV000010'),
    ('2023-11-01', 20000000.00, 6000000.00, 2000000.00, 'MNV000011'),
    ('2023-11-01', 55000000.00, 6100000.00, 2050000.00, 'MNV000012'),
    ('2023-11-01', 45000000.00, 6200000.00, 2100000.00, 'MNV000013'),
    ('2023-11-01', 20000000.00, 6300000.00, 2150000.00, 'MNV000014'),
    ('2023-11-01', 20000000.00, 6400000.00, 2200000.00, 'MNV000015'),
    ('2023-11-01', 20000000.00, 6500000.00, 2250000.00, 'MNV000016'),
    ('2023-11-01', 20000000.00, 6600000.00, 2300000.00, 'MNV000017'),
    ('2023-11-01', 20000000.00, 6700000.00, 2350000.00, 'MNV000018'),
    ('2023-11-01', 20000000.00, 6800000.00, 2400000.00, 'MNV000019'),
    ('2023-11-01', 20000000.00, 6900000.00, 2450000.00, 'MNV000020'),
    ('2023-11-01', 20000000.00, 7000000.00, 2500000.00, 'MNV000021'),
    ('2023-11-01', 20000000.00, 7100000.00, 2550000.00, 'MNV000022'),
    ('2023-11-01', 55000000.00, 7200000.00, 2600000.00, 'MNV000023'),
    ('2023-11-01', 45000000.00, 7300000.00, 2650000.00, 'MNV000024'),
    ('2023-11-01', 20000000.00, 7400000.00, 2700000.00, 'MNV000025'),
    ('2023-11-01', 20000000.00, 7500000.00, 2750000.00, 'MNV000026'),
    ('2023-11-01', 55000000.00, 7600000.00, 2800000.00, 'MNV000027'),
    ('2023-11-01', 45000000.00, 7700000.00, 2850000.00, 'MNV000028'),
    ('2023-11-01', 20000000.00, 7800000.00, 2900000.00, 'MNV000029'),
    ('2023-11-01', 20000000.00, 7900000.00, 2950000.00, 'MNV000030'),
    ('2023-11-01', 20000000.00, 8000000.00, 3000000.00, 'MNV000031'),
    ('2023-11-01', 55000000.00, 8100000.00, 3050000.00, 'MNV000032'),
    ('2023-11-01', 45000000.00, 8200000.00, 3100000.00, 'MNV000033'),
    ('2023-11-01', 20000000.00, 8300000.00, 3150000.00, 'MNV000034'),
    ('2023-11-01', 20000000.00, 8400000.00, 3200000.00, 'MNV000035'),
    ('2023-11-01', 85000000.00, 8500000.00, 3250000.00, 'MNV000036'),
    ('2023-11-01', 75000000.00, 8600000.00, 3300000.00, 'MNV000037'),
    ('2023-11-01', 75000000.00, 8700000.00, 3350000.00, 'MNV000038'),
    ('2023-11-01', 55000000.00, 8800000.00, 3400000.00, 'MNV000039'),
    ('2023-11-01', 45000000.00, 8900000.00, 3450000.00, 'MNV000040'),
    ('2023-11-01', 20000000.00, 9000000.00, 3500000.00, 'MNV000041'),
    ('2023-11-01', 20000000.00, 9100000.00, 3550000.00, 'MNV000042'),
    ('2023-11-01', 20000000.00, 9200000.00, 3600000.00, 'MNV000043'),
    ('2023-11-01', 20000000.00, 9300000.00, 3650000.00, 'MNV000044'),
    ('2023-11-01', 20000000.00, 9400000.00, 3700000.00, 'MNV000045'),
    ('2023-11-01', 20000000.00, 9500000.00, 3750000.00, 'MNV000046'),
    ('2023-11-01', 55000000.00, 9600000.00, 3800000.00, 'MNV000047'),
    ('2023-11-01', 45000000.00, 9700000.00, 3850000.00, 'MNV000048'),
    ('2023-11-01', 20000000.00, 9800000.00, 3900000.00, 'MNV000049'),
    ('2023-11-01', 20000000.00, 9900000.00, 3950000.00, 'MNV000050'),
    ('2023-11-01', 20000000.00, 10000000.00, 4000000.00, 'MNV000051'),
    ('2023-11-01', 20000000.00, 10050000.00, 4050000.00, 'MNV000052'),
    ('2023-11-01', 20000000.00, 10100000.00, 4100000.00, 'MNV000053'),
    ('2023-11-01', 20000000.00, 10150000.00, 4150000.00, 'MNV000054'),
    ('2023-11-01', 20000000.00, 10200000.00, 4200000.00, 'MNV000055'),
    ('2023-11-01', 20000000.00, 10250000.00, 4250000.00, 'MNV000056'),
    ('2023-11-01', 20000000.00, 10300000.00, 4300000.00, 'MNV000057'),
    ('2023-11-01', 55000000.00, 10350000.00, 4350000.00, 'MNV000058'),
    ('2023-11-01', 45000000.00, 10400000.00, 4400000.00, 'MNV000059'),
    ('2023-11-01', 20000000.00, 10450000.00, 4450000.00, 'MNV000060'),
    ('2023-11-01', 20000000.00, 10500000.00, 4500000.00, 'MNV000061'),
    ('2023-11-01', 55000000.00, 10550000.00, 4550000.00, 'MNV000062'),
    ('2023-11-01', 45000000.00, 10600000.00, 4600000.00, 'MNV000063'),
    ('2023-11-01', 20000000.00, 10650000.00, 4650000.00, 'MNV000064'),
    ('2023-11-01', 20000000.00, 10700000.00, 4700000.00, 'MNV000065'),
    ('2023-11-01', 20000000.00, 10750000.00, 4750000.00, 'MNV000066'),
    ('2023-11-01', 55000000.00, 10800000.00, 4800000.00, 'MNV000067'),
    ('2023-11-01', 45000000.00, 10850000.00, 4850000.00, 'MNV000068'),
    ('2023-11-01', 20000000.00, 10900000.00, 4900000.00, 'MNV000069'),
    ('2023-11-01', 20000000.00, 10950000.00, 4950000.00, 'MNV000070'),

	('2023-12-01', 85000000.00, 10000000.00, 100000.00, 'MNV000001'),
    ('2023-12-01', 75000000.00, 10000000.00, 150000.00, 'MNV000002'),
    ('2023-12-01', 75000000.00, 10000000.00, 150000.00, 'MNV000003'),
    ('2023-12-01', 55000000.00, 5300000.00, 1650000.00, 'MNV000004'),
    ('2023-12-01', 45000000.00, 5400000.00, 1700000.00, 'MNV000005'),
    ('2023-12-01', 20000000.00, 5500000.00, 1750000.00, 'MNV000006'),
    ('2023-12-01', 20000000.00, 5600000.00, 1800000.00, 'MNV000007'),
    ('2023-12-01', 20000000.00, 5700000.00, 1850000.00, 'MNV000008'),
    ('2023-12-01', 20000000.00, 5800000.00, 1900000.00, 'MNV000009'),
    ('2023-12-01', 20000000.00, 5900000.00, 1950000.00, 'MNV000010'),
    ('2023-12-01', 20000000.00, 6000000.00, 2000000.00, 'MNV000011'),
    ('2023-12-01', 55000000.00, 6100000.00, 2050000.00, 'MNV000012'),
    ('2023-12-01', 45000000.00, 6200000.00, 2100000.00, 'MNV000013'),
    ('2023-12-01', 20000000.00, 6300000.00, 2150000.00, 'MNV000014'),
    ('2023-12-01', 20000000.00, 6400000.00, 2200000.00, 'MNV000015'),
    ('2023-12-01', 20000000.00, 6500000.00, 2250000.00, 'MNV000016'),
    ('2023-12-01', 20000000.00, 6600000.00, 2300000.00, 'MNV000017'),
    ('2023-12-01', 20000000.00, 6700000.00, 2350000.00, 'MNV000018'),
    ('2023-12-01', 20000000.00, 6800000.00, 2400000.00, 'MNV000019'),
    ('2023-12-01', 20000000.00, 6900000.00, 2450000.00, 'MNV000020'),
    ('2023-12-01', 20000000.00, 7000000.00, 2500000.00, 'MNV000021'),
    ('2023-12-01', 20000000.00, 7100000.00, 2550000.00, 'MNV000022'),
    ('2023-12-01', 55000000.00, 7200000.00, 2600000.00, 'MNV000023'),
    ('2023-12-01', 45000000.00, 7300000.00, 2650000.00, 'MNV000024'),
    ('2023-12-01', 20000000.00, 7400000.00, 2700000.00, 'MNV000025'),
    ('2023-12-01', 20000000.00, 7500000.00, 2750000.00, 'MNV000026'),
    ('2023-12-01', 55000000.00, 7600000.00, 2800000.00, 'MNV000027'),
    ('2023-12-01', 45000000.00, 7700000.00, 2850000.00, 'MNV000028'),
    ('2023-12-01', 20000000.00, 7800000.00, 2900000.00, 'MNV000029'),
    ('2023-12-01', 20000000.00, 7900000.00, 2950000.00, 'MNV000030'),
    ('2023-12-01', 20000000.00, 8000000.00, 3000000.00, 'MNV000031'),
    ('2023-12-01', 55000000.00, 8100000.00, 3050000.00, 'MNV000032'),
    ('2023-12-01', 45000000.00, 8200000.00, 3100000.00, 'MNV000033'),
    ('2023-12-01', 20000000.00, 8300000.00, 3150000.00, 'MNV000034'),
    ('2023-12-01', 20000000.00, 8400000.00, 3200000.00, 'MNV000035'),
    ('2023-12-01', 85000000.00, 8500000.00, 3250000.00, 'MNV000036'),
    ('2023-12-01', 75000000.00, 8600000.00, 3300000.00, 'MNV000037'),
    ('2023-12-01', 75000000.00, 8700000.00, 3350000.00, 'MNV000038'),
    ('2023-12-01', 55000000.00, 8800000.00, 3400000.00, 'MNV000039'),
    ('2023-12-01', 45000000.00, 8900000.00, 3450000.00, 'MNV000040'),
    ('2023-12-01', 20000000.00, 9000000.00, 3500000.00, 'MNV000041'),
    ('2023-12-01', 20000000.00, 9100000.00, 3550000.00, 'MNV000042'),
    ('2023-12-01', 20000000.00, 9200000.00, 3600000.00, 'MNV000043'),
    ('2023-12-01', 20000000.00, 9300000.00, 3650000.00, 'MNV000044'),
    ('2023-12-01', 20000000.00, 9400000.00, 3700000.00, 'MNV000045'),
    ('2023-12-01', 20000000.00, 9500000.00, 3750000.00, 'MNV000046'),
    ('2023-12-01', 55000000.00, 9600000.00, 3800000.00, 'MNV000047'),
    ('2023-12-01', 45000000.00, 9700000.00, 3850000.00, 'MNV000048'),
    ('2023-12-01', 20000000.00, 9800000.00, 3900000.00, 'MNV000049'),
    ('2023-12-01', 20000000.00, 9900000.00, 3950000.00, 'MNV000050'),
    ('2023-12-01', 20000000.00, 10000000.00, 4000000.00, 'MNV000051'),
    ('2023-12-01', 20000000.00, 10050000.00, 4050000.00, 'MNV000052'),
    ('2023-12-01', 20000000.00, 10100000.00, 4100000.00, 'MNV000053'),
    ('2023-12-01', 20000000.00, 10150000.00, 4150000.00, 'MNV000054'),
    ('2023-12-01', 20000000.00, 10200000.00, 4200000.00, 'MNV000055'),
    ('2023-12-01', 20000000.00, 10250000.00, 4250000.00, 'MNV000056'),
    ('2023-12-01', 20000000.00, 10300000.00, 4300000.00, 'MNV000057'),
    ('2023-12-01', 55000000.00, 10350000.00, 4350000.00, 'MNV000058'),
    ('2023-12-01', 45000000.00, 10400000.00, 4400000.00, 'MNV000059'),
    ('2023-12-01', 20000000.00, 10450000.00, 4450000.00, 'MNV000060'),
    ('2023-12-01', 20000000.00, 10500000.00, 4500000.00, 'MNV000061'),
    ('2023-12-01', 55000000.00, 10550000.00, 4550000.00, 'MNV000062'),
    ('2023-12-01', 45000000.00, 10600000.00, 4600000.00, 'MNV000063'),
    ('2023-12-01', 20000000.00, 10650000.00, 4650000.00, 'MNV000064'),
    ('2023-12-01', 20000000.00, 10700000.00, 4700000.00, 'MNV000065'),
    ('2023-12-01', 20000000.00, 10750000.00, 4750000.00, 'MNV000066'),
    ('2023-12-01', 55000000.00, 10800000.00, 4800000.00, 'MNV000067'),
    ('2023-12-01', 45000000.00, 10850000.00, 4850000.00, 'MNV000068'),
    ('2023-12-01', 20000000.00, 10900000.00, 4900000.00, 'MNV000069'),
    ('2023-12-01', 20000000.00, 10950000.00, 4950000.00, 'MNV000070');

INSERT INTO TaiKhoan (MaNhanVien, MatKhau, Quyen)
VALUES
    ('MNV000002', '2222', N'Quản lý nhân sự');
-- Lệnh xóa bảng	 
DROP TABLE Luong;
DROP TABLE NhanVien;
DROP TABLE PhongBan;