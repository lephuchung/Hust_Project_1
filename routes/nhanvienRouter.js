const express = require("express");
const app = express();
const sql = require('../connectDB');
const {check, validationResult} = require ("express-validator");
const nhanvienRouter = express.Router();

nhanvienRouter.get("/QuanLyNhanVien.ejs", (req, res) => {
    res.render("../views/QuanLyNhanVien/QuanLyNhanVien")
})

nhanvienRouter.get("/SuaNhanVien.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const name = req.query.tenNguoiDung; 
    let query = `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.HoTen like N'%${name}%'`,
            "identity": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.SoCMNDCCCD like '%${name}%'`,
            "employeeId": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.MaNhanVien like '%${name}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.NgaySinh));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            NgaySinh: newDateString,
        }
        return newRecord;
    })
    res.render("../views/QuanLyNhanVien/SuaNhanVien.ejs",{result: formatedResult})
})

nhanvienRouter.get("/FormSuaNhanVien.ejs", async (req,res) => {
    const NhanVienID = req.query.NhanVienID;
    let query = `select * from NhanVien where MaNhanVien = '${NhanVienID}'`;
    const result = (await sql.query(query)).recordset;
    res.render("../views/QuanLyNhanVien/FormSuaNhanVien.ejs", {result: result[0]});
})

nhanvienRouter.post("/SuaNhanVien.ejs", async (req, res) => {
    const MaNhanVien = req.body.MaNhanVien;
    const HoTen = req.body.HoTen;
    const SoDienThoai = req.body.SoDienThoai;
    const SoCMNDCCCD = req.body.SoCMNDCCCD;
    const NgaySinh = req.body.NgaySinh;
    const TonGiao = req.body.TonGiao;
    const ChucVu = req.body.ChucVu;
    const Email = req.body.Email;
    const DiaChi = req.body.DiaChi;
    const QueQuan = req.body.QueQuan;
    const GioiTinh = req.body.GioiTinh;
    let regex = /^[0-9]+$/;
    if(SoCMNDCCCD.length == 12 || regex.test(SoCMNDCCCD) || regex.test(SoDienThoai) || SoCMNDCCCD.length == 10){
        let query = `select * from NhanVien where SoCMNDCCCD = '${SoCMNDCCCD}'`
        const test = (await (sql.query(query))).recordset;
        if(test.length != 0){
            query = `update NhanVien set Hoten = N'${HoTen}', SoDienThoai = N'${SoDienThoai}', SoCMNDCCCD = N'${SoCMNDCCCD}' ,NgaySinh = N'${NgaySinh}', TonGiao = N'${TonGiao}', ChucVu = N'${ChucVu}', Email = N'${Email}', DiaChi = N'${DiaChi}', QueQuan = N'${QueQuan}', GioiTinh = N'${GioiTinh}' WHERE MaNhanVien ='${MaNhanVien}'`.toString();
            const test1 = (await sql.query(query)).recordset
        }    
    }
    query = `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv`
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.NgaySinh));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            NgaySinh: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyNhanVien/SuaNhanVien.ejs",{result: formatedResult})
})

nhanvienRouter.get("/ThemNhanVien.ejs", (req, res) => {
    res.render("../views/QuanLyNhanVien/ThemNhanVien.ejs", {errors: ''})
})

nhanvienRouter.post("/ThemNhanVien.ejs", 
    [
        check('TenNhanVien').notEmpty().withMessage('Bạn cần điền họ và tên!'),
        check('TenNhanVien').isAlpha().withMessage('Bạn cần nhập đúng định dạng tên!'),
        check('SoDienThoai').notEmpty().withMessage('Bạn cần điền số điện thoại!'),
        check('SoDienThoai').isNumeric().withMessage('Bạn cần nhập đúng định dạng số điện thoại!'),
        check('SoDienThoai').isLength({min: 10, max: 10}).withMessage('Bạn cần nhập đầy đủ số điện thoại!'),
        check('CCCD').isNumeric().withMessage('Bạn cần điền đúng định dạng số CDCD/CMND!'),
        check('CCCD').notEmpty().withMessage('Bạn cần điền số CDCD/CMND!'),
        check('CCCD').isLength({min: 12, max: 12}).withMessage('Bạn cần nhập đầy đủ số CCCD/CMND!'),
        check('LuongCoBan').notEmpty().withMessage('Bạn cần điền lương!'),
        check('LuongCoBan').isNumeric().withMessage('Bạn cần điền đúng định dạng lương!'),
        check('LuongCoBan').isLength({min: 5, max: 10}).withMessage('Bạn cần nhập đầy đủ số CCCD/CMND!'),
    ] , async (req, res) => {
        const errors = validationResult(req);
        if(!errors.isEmpty()){
            res.render("../views/QuanLyNhanVien/ThemNhanVien.ejs", {errors: errors.mapped() });
        } else{
            const ID = req.body.CCCD;
            const checkExist = `select SoCMNDCCCD from NhanVien where SoCMNDCCCD = '${ID}'`.toString();
            if((await sql.query(checkExist)).recordset.length){
                console.log("Nhan vien da ton tai");
            } else{
                const name = req.body.TenNhanVien;
                const birth = req.body.txtDate;
                const DiaChi = req.body.DiaChi;
                const gender = req.body.gioitinh;
                const sdt = req.body.SoDienThoai;
                const email = req.body.Email;
                const queQuan = req.body.QueQuan;
                const ChucVu = req.body.ChucVu;
                const themNhanVien = `INSERT INTO NhanVien (HoTen, NgaySinh, SoDienThoai, Email, SoCMNDCCCD, DiaChi, QueQuan, GioiTinh, ChucVu) VALUES    
                (N'${name}', N'${birth}', N'${sdt}', N'${email}', N'${ID}', N'${DiaChi}', N'${queQuan}', N'${gender}', N'${ChucVu}')`.toString();
                await sql.query(themNhanVien)
            };
            res.render("../views/QuanLyNhanVien/ThemNhanVien.ejs", {errors: [] });
        }
})

nhanvienRouter.get("/TimNhanVien.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const name = req.query.tenNguoiDung; 
    let query = `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.HoTen like N'%${name}%'`,
            "identity": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.SoCMNDCCCD like '%${name}%'`,
            "employeeId": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.MaNhanVien like '%${name}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.NgaySinh));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            NgaySinh: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyNhanVien/TimNhanVien.ejs",{result: formatedResult})
})

nhanvienRouter.get("/XoaNhanVien.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const name = req.query.tenNguoiDung; 
    let query = `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.HoTen like N'%${name}%'`,
            "identity": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.SoCMNDCCCD like '%${name}%'`,
            "employeeId": `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv
            where nv.MaNhanVien like '%${name}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.NgaySinh));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            NgaySinh: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyNhanVien/XoaNhanVien.ejs",{result: formatedResult})
})

nhanvienRouter.post("/XoaNhanVien.ejs", async (req,res) => {
    const NhanVienID = req.body.NhanVienID;
    const deleteLuongQuery = `delete from Luong where MaNhanVien = '${NhanVienID}'`.toString();
    await sql.query(deleteLuongQuery);
    const deleteTaiKhoanQuery = `delete from TaiKhoan where MaNhanVien = '${NhanVienID}'`.toString();
    await sql.query(deleteTaiKhoanQuery);
    const deleteNhanVienQuery = `delete from NhanVien where MaNhanVien = '${NhanVienID}'`.toString();
    await sql.query(deleteNhanVienQuery);
    let query = `select distinct nv.MaNhanVien, nv.HoTen, nv.NgaySinh, nv.GioiTinh, nv.SoCMNDCCCD ,nv.DiaChi, nv.SoDienThoai, nv.Email, nv.QueQuan, nv.TonGiao, nv.ChucVu from NhanVien as nv`
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.NgaySinh));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            NgaySinh: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyNhanVien/XoaNhanVien.ejs",{result: formatedResult})
})

nhanvienRouter.get("/ThongKeNhanVien.ejs", (req, res) => {
    res.render("../views/QuanLyNhanVien/ThongKeNhanVien.ejs")
})

module.exports = nhanvienRouter;