const express = require('express');
const app = express();
const {conn, sql} = require('./connectDB') 
const nhanvienRouter = require("./routes/nhanvienRouter")
const luongRouter = require("./routes/luongRouter")
const taiKhoanRouter = require("./routes/taiKhoanRouter")

app.use(express.urlencoded({extended:false}));
app.use("/QuanLyNhanVien", nhanvienRouter)
app.use("/QuanLyLuong", luongRouter)
app.use("/QuanLyTaiKhoan", taiKhoanRouter)

app.set('view engine', 'ejs'); // engine để render

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

app.use("/", express.static("public"))
//  http://localhost:5000/css/base.css -> public/css/base.css


// http://localhost:5000/public/css/base.css

app.get("/QuanLyNhanVien", (req,res) => { // đường dẫn để xử lý logic
    res.render("QuanLyNhanVien/QuanLyNhanVien.ejs")
})

app.get("/QuanLyLuong", (req,res) => {
    res.render("QuanLyLuong/QuanLyLuong.ejs")
})

app.get("/QuanLyTaiKhoan", (req,res) => {

    console.log("Query", req.query)

    const searchValue = req.query.tenNguoiDung

    console.log("Body", req.body)

    // console.log(req.params)

    // Logic quẻy database -> kết quả
    // Render ra ejs và rải kết quả vào ejs
    res.render("QuanLyTaiKhoan/QuanLyTaiKhoan.ejs")
})

app.post("/QuanLyTaiKhoan", (req,res) => {

    console.log("Query", req.query)


    console.log("Body", req.body)

    const searchValue = req.body.tenNguoiDung
    console.log(searchValue)

    // console.log(req.params)

    // Logic quẻy database -> kết quả
    // Render ra ejs và rải kết quả vào ejs
    res.render("QuanLyTaiKhoan/QuanLyTaiKhoan.ejs")
})

app.get("/Home", (req,res) => {
    res.render("Home.ejs")
})

app.get("/", (req,res) => {
    res.render("DangNhap.ejs")
} )

app.listen(5000);