const express = require("express");
const app = express();
const sql = require('../connectDB') ;
const luongRouter = express.Router();

luongRouter.get("/QuanLyLuong.ejs", (req, res) => {
    res.render("../views/QuanLyLuong/QuanLyLuong.ejs")
})

luongRouter.get("/SuaLuong.ejs", (req, res) => {
    res.render("../views/QuanLyLuong/SuaLuong.ejs")
})

luongRouter.get("/TimLuong.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const chon = req.query.chon;
    let query = `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
    join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.HoTen like N'%${chon}%'`,
            "identity": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.SoCMNDCCCD like '%${chon}%'`,
            "employeeId": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.MaNhanVien like '%${chon}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        // Thay cac method o day khong
        // Bay gio thu console.log ra de test xem format nao may ung; thu dd-mm-yyyy di
        const newDate = (new Date(record.ThoiGian));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            ThoiGian: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyLuong/TimLuong.ejs",{result: formatedResult})
})

module.exports = luongRouter;

