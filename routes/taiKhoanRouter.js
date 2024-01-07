const express = require("express");
const app = express();
const sql = require('../connectDB');
const {check, validationResult} = require ("express-validator");
const alert = require('alert'); 
const taiKhoanRouter = express.Router();

taiKhoanRouter.get("/QuanLyTaiKhoan.ejs", (req, res) => {
    res.render("../views/QuanLyTaiKhoan/QuanLyTaiKhoan.ejs")
})

taiKhoanRouter.get("/SuaTaiKhoan.ejs", (req, res) => {
    res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs",{errors: []})
})

taiKhoanRouter.post("/SuaTaiKhoan.ejs",    
    [
        check('MaNhanVien').notEmpty().withMessage('Bạn cần điền mã nhân viên'),
    ] , async (req, res) => {
        const errors = validationResult(req);
        if(!errors.isEmpty()){
            res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: errors.mapped() });
        } else{
            const MaNhanVien = req.body.MaNhanVien;
            const checkExist = `select MaNhanVien from TaiKhoan where MaNhanVien = '${MaNhanVien}'`.toString();
            if((await sql.query(checkExist)).recordset.length){
                const MatKhau = req.body.MatKhau;
                const repassword = req.body.repassword;
                const Quyen = req.body.Quyen;
                console.log(MatKhau);
                console.log(Quyen != undefined);
                if(MatKhau.length == 0 && MatKhau == repassword){ 
                    if(Quyen == undefined){
                        return res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: [] });
                    } else if(Quyen != undefined) {
                        let query = `update TaiKhoan set Quyen = N'${Quyen}' WHERE MaNhanVien ='${MaNhanVien}'`;
                        await sql.query(query)
                        return res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: [] });
                    }
                } else if(MatKhau.length != 0 && MatKhau == repassword){
                    if(Quyen == undefined){
                        let query = `update TaiKhoan set MatKhau = N'${MatKhau}' WHERE MaNhanVien ='${MaNhanVien}'`;
                        await sql.query(query)
                        return res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: [] });
                    } else {
                        let query = `update TaiKhoan set Quyen = N'${Quyen}', MatKhau = N'${MatKhau}' WHERE MaNhanVien ='${MaNhanVien}'`;
                        await sql.query(query)
                        return res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: [] });
                    }
                }
            }
            return res.render("../views/QuanLyTaiKhoan/SuaTaiKhoan.ejs", {errors: [] });
        }
})

taiKhoanRouter.get("/ThemTaiKhoan.ejs", (req, res) => {
    res.render("../views/QuanLyTaiKhoan/ThemTaiKhoan.ejs",{errors: [] })
})

taiKhoanRouter.post("/ThemTaiKhoan.ejs",     
    [
        check('MaNhanVien').notEmpty().withMessage('Bạn cần điền mã nhân viên'),
        check('MatKhau').notEmpty().withMessage('Bạn cần điền mật khẩu!'),
        check('repassword').notEmpty().withMessage('Bạn cần xác nhận lại mật khẩu!'),
        check('Quyen').notEmpty().withMessage('Bạn cần chọn quyền cho tài khoản!'),
    ] , async (req, res) => {
        const errors = validationResult(req);
        if(!errors.isEmpty()){
            res.render("../views/QuanLyTaiKhoan/ThemTaiKhoan.ejs", {errors: errors.mapped() });
        } else{
            const MaNhanVien = req.body.MaNhanVien;
            const checkExist = `select MaNhanVien from TaiKhoan where MaNhanVien = '${MaNhanVien}'`.toString();
            if((await sql.query(checkExist)).recordset.length){
                res.render("../views/QuanLyTaiKhoan/ThemTaiKhoan.ejs", {errors: [] });
            } else{
                const MatKhau = req.body.MatKhau;
                const repassword = req.body.repassword;
                const Quyen = req.body.Quyen;
                if(MatKhau == repassword){ 
                    const themNhanVien = `INSERT INTO TaiKhoan (MaNhanVien, MatKhau, Quyen) VALUES    
                    (N'${MaNhanVien}', N'${MatKhau}', N'${Quyen}')`.toString();
                    await sql.query(themNhanVien)
                    res.render("../views/QuanLyTaiKhoan/ThemTaiKhoan.ejs", {errors: [] });
                } else{
                    res.render("../views/QuanLyTaiKhoan/ThemTaiKhoan.ejs", {errors: [] });
                }
            };
        }
})

taiKhoanRouter.get("/TimTaiKhoan.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const name = req.query.chon; 
    let query = `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
    join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.HoTen like N'%${name}%'`,
            "identity": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.SoCMNDCCCD like '%${name}%'`,
            "employeeId": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.MaNhanVien like '%${name}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    res.render("../views/QuanLyTaiKhoan/TimTaiKhoan.ejs",{ result: result})
})

taiKhoanRouter.get("/XoaTaiKhoan.ejs", async (req, res) => {
    const selection = req.query.luaChonTimKiem;
    const name = req.query.chon; 
    let query = `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
    join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien`;
    if (selection) {
        const selecitonQueryMap = {
            "name": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.HoTen like N'%${name}%'`,
            "identity": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.SoCMNDCCCD like '%${name}%'`,
            "employeeId": `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
            join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien            
            where NhanVien.MaNhanVien like '%${name}%'`,
        }
        query = selecitonQueryMap[selection];
    }
    const result = (await sql.query(query)).recordset;
    res.render("../views/QuanLyTaiKhoan/XoaTaiKhoan.ejs",{ result: result})
})

taiKhoanRouter.post("/XoaTaiKhoan.ejs", async (req,res) => {
    const NhanVienID = req.body.NhanVienID;
    const deleteTaiKhoanQuery = `delete from TaiKhoan where MaNhanVien = '${NhanVienID}'`.toString();
    await sql.query(deleteTaiKhoanQuery);
    let query = `select tk.MaNhanVien, NhanVien.HoTen, NhanVien.SoCMNDCCCD, tk.MatKhau, tk.Quyen from TaiKhoan as tk
    join NhanVien on tk.MaNhanVien = NhanVien.MaNhanVien`
    const result = (await sql.query(query)).recordset;
    return res.render("../views/QuanLyTaiKhoan/XoaTaiKhoan.ejs",{result: result})
})

module.exports = taiKhoanRouter;
