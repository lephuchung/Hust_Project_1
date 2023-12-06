-- Trigger lưu lại thông tin cho các bảng deleted
-- 1. Bảng lương
CREATE TRIGGER trigger_DeleteLuong
ON Luong
AFTER DELETE
AS
BEGIN
    INSERT INTO Deleted_Luong (MaLuong, ThoiGian, LuongCoBan, Thuong, Phat, MaNhanVien)
    SELECT STT, MaLuong, ThoiGian, LuongCoBan, Thuong, Phat, MaNhanVien
    FROM deleted;
END;

-- 2. Bảng nhân viên
CREATE TRIGGER trigger_DeleteNhanVien
ON NhanVien
AFTER DELETE
AS
BEGIN
    INSERT INTO Deleted_NhanVien (MaNhanVien, HoTen, NgaySinh, TonGiao, ChucVu, SoDienThoai, Email, SoCMNDCCCD, DiaChi, QueQuan, GioiTinh, MaPhongBan)
    SELECT STT, MaNhanVien, HoTen, NgaySinh, TonGiao, ChucVu, SoDienThoai, Email, SoCMNDCCCD, DiaChi, QueQuan, GioiTinh, MaPhongBan
    FROM deleted;
END;

-- 3. Bảng phòng ban
CREATE TRIGGER trigger_DeletePhongBan
ON PhongBan
AFTER DELETE
AS
BEGIN
    INSERT INTO Deleted_PhongBan (MaPhongBan, TenPhongBan, ChiNhanh)
    SELECT STT, MaPhongBan, TenPhongBan, ChiNhanh
    FROM deleted;
END;
