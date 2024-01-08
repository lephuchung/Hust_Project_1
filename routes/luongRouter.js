const express = require("express");
const app = express();
const sql = require('../connectDB') ;
const {check, validationResult} = require ("express-validator");
const luongRouter = express.Router();

luongRouter.get("/QuanLyLuong.ejs", (req, res) => {
    res.render("../views/QuanLyLuong/QuanLyLuong.ejs")
})

luongRouter.get("/SuaLuong.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const chon = req.query.chon;
    let query = `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
    join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
    order by Luong.MaLuong`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.HoTen like N'%${chon}%'
            order by Luong.MaLuong`,
            "identity": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.SoCMNDCCCD like '%${chon}%'
            order by Luong.MaLuong`,
            "employeeId": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.MaNhanVien like '%${chon}%'
            order by Luong.MaLuong`,
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
    return res.render("../views/QuanLyLuong/SuaLuong.ejs",{result: formatedResult})
})

luongRouter.get("/FormSuaLuong.ejs", async (req,res) => {
    const MaLuong = req.query.MaLuong;
    let query = `select Luong.MaLuong ,Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.LuongCoBan, Luong.Thuong, Luong.Phat
    from Luong join NhanVien
    on Luong.MaNhanVien = NhanVien.MaNhanVien
    where MaLuong = '${MaLuong}'`;
    const result = (await sql.query(query)).recordset;
    res.render("../views/QuanLyLuong/FormSuaLuong.ejs", {result: result[0]});
})


luongRouter.post("/SuaLuong.ejs", async (req, res) => {
    const MaLuong = req.body.MaLuong;
    let LuongCoBan = req.body.LuongCoBan + 0;
    let Thuong = req.body.Thuong + 0;
    let Phat = req.body.Phat + 0;
    let query = `update Luong set LuongCoBan = '${LuongCoBan}', Thuong = '${Thuong}', Phat = '${Phat}' WHERE MaLuong='${MaLuong} '`;
    await sql.query(query)
    query = `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
    join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
    order by Luong.MaLuong`
    const result = (await sql.query(query)).recordset;
    const formatedResult = result.map(record => {
        const newDate = (new Date(record.ThoiGian));
        const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
        const newRecord = {
            ...record,
            ThoiGian: newDateString,
        }
        return newRecord;
    })
    return res.render("../views/QuanLyLuong/SuaLuong.ejs",{result: formatedResult})
})

luongRouter.get("/TimLuong.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const chon = req.query.chon;
    let query = `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
    join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
    order by Luong.MaLuong`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.HoTen like N'%${chon}%'
            order by Luong.MaLuong`,
            "identity": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.SoCMNDCCCD like '%${chon}%'
            order by Luong.MaLuong`,
            "employeeId": `select Luong.MaLuong, Luong.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat from Luong
            join NhanVien on Luong.MaNhanVien = NhanVien.MaNhanVien
            where NhanVien.MaNhanVien like '%${chon}%'
            order by Luong.MaLuong`,
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

