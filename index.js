const express = require('express');
const app = express();
const session = require("express-session");
const sql = require('./connectDB');
const nhanvienRouter = require("./routes/nhanvienRouter")
const luongRouter = require("./routes/luongRouter")
const taiKhoanRouter = require("./routes/taiKhoanRouter")

app.use(express.urlencoded({extended:false}));
app.set('view engine', 'ejs'); // engine để render
app.use("/", express.static("public"))
//  http://localhost:5000/css/base.css -> public/css/base.css
// http://localhost:5000/public/css/base.css
app.use(session({
    secret: 'heyheyheyhey',
    resave: true,
    saveUninitialized: true,
    cookie: { maxAge: 1000 * 60 * 60, sameSite: "strict" },
    name: "ssid",
  }))


// "/" đường đã ở trình duyệt, "publ;ic" đường đẵn của file system
// http://localhost:5000/public/css/báse.css ~ public/css/base.css

// 2 lọai đường dẫn: 1 là đường dẫn trình duyệt và đường dẫn file system
// express.static: ánh xạ từ đường dẫn trình duyệt sang file system

// http://localhost:5000/public/css/base.css -> base.css ở đâu trong file system

// http://localhost:5000/css/base.css -> public(file system)/css/base.css

// http://localhost:5000/public/css/base.css -> public(file system)/css/base.css
// http://localhost:5000/abc/css/base.css -> public

// http://localhost:5000/css/base.css

// app.use("/abc", express.static("public")) // file tĩnh, css, js ở client, ảnh file ...



app.use("/QuanLyNhanVien", nhanvienRouter)
app.use("/QuanLyLuong", luongRouter)
app.use("/QuanLyTaiKhoan", taiKhoanRouter)

let userr;

app.get("/DangNhap", (req,res) => {
    res.render("DangNhap.ejs")
})

app.post("/Profile", async(req, res) =>{
    MaNhanVien = req.body.MaNhanVien;
    const MatKhau = req.body.MatKhau;
    let query = `select * from TaiKhoan where MaNhanVien = '${MaNhanVien}' and MatKhau = '${MatKhau}'`
    const user = (await sql.query(query)).recordset[0];
    if(!user){
        return res.render("DangNhap.ejs")   
    } else {
        if(user.Quyen == "Nhân viên"){
            userr = user.MaNhanVien;
            let query = `select NhanVien.MaNhanVien, NhanVien.HoTen, NhanVien.NgaySinh, NhanVien.TonGiao, NhanVien.ChucVu, NhanVien.SoDienThoai, NhanVien.Email,
            NhanVien.SoCMNDCCCD, NhanVien.DiaChi, NhanVien.QueQuan, NhanVien.GioiTinh, Luong.MaLuong, Luong.ThoiGian, Luong.LuongCoBan, Luong.Thuong, Luong.Phat
            from NhanVien join Luong
            on NhanVien.MaNhanVien = Luong.MaNhanVien
            where NhanVien.MaNhanVien ='${userr}'`;
            const result = (await sql.query(query)).recordset;
            const formatedResult = result.map(record => {
                const newDate = (new Date(record.NgaySinh));
                const newDate1 = (new Date(record.ThoiGian));
                const newDateString = `${newDate.getUTCDate()}/${newDate.getUTCMonth()+ 1}/${newDate.getUTCFullYear()}`;
                const newDateString1 = `${newDate1.getUTCDate()}/${newDate1.getUTCMonth()+ 1}/${newDate1.getUTCFullYear()}`;
                const newRecord = {
                    ...record,
                    NgaySinh: newDateString,
                    ThoiGian: newDateString1,
                }
                return newRecord;
            })
            res.render("Profile.ejs",{result: formatedResult});
        } else {
            res.redirect("/Home")
        }
    }
})

app.get("/QuanLyNhanVien", (req,res) => { // đường dẫn để xử lý logic
    res.render("QuanLyNhanVien/QuanLyNhanVien.ejs")
})

app.get("/QuanLyLuong", (req,res) => {
    res.render("QuanLyLuong/QuanLyLuong.ejs")
})

app.get("/QuanLyTaiKhoan", (req,res) => {
    res.render("QuanLyTaiKhoan/QuanLyTaiKhoan.ejs")
})

app.get("/Home" ,(req,res) => {
    res.render("Home.ejs")
})

app.listen(5000);