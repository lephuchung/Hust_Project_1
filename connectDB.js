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


/* var config = {
    server: "server_name",
    database: "database_name",
    user: "user_name",
    password: "password_name",
    driver: "mssql",
    options: {
        trustedConnection: true,
        encrypt: false
    }
} */

sql.connect(config, function(err) {
    if (err) {
      console.log("Failed to connect to database: " + err);
    } else {
      console.log("Connected to database to get Users table info");
    }
  });


module.exports = sql;