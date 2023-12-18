const sql = require("mssql");
var config = {
    server: "LAPTOP-1L2T8PSB\\SQLEXPRESS",
    database: "QuanLyNhanVien_Prj1",
    user: "nk",
    password: "motconvit123",
    driver: "mssql",
    options: {
        trustedConnection: true,
        encrypt: false
    }
}

sql.connect(config,function(err){
    if(err){
        console.log(err);
    }
    var request = new sql.Request();
    request.query("select top(10) * from Luong", function(err,records){
        if(err){
            console.log(err);
        } else {
            console.log(records);
        }
    })
})