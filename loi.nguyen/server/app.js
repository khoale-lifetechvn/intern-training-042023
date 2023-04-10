const express = require('express');
const cors = require('cors')
const mysql = require('mysql2')

const app = express();
const port = process.env.PORT || 5000;

const connection = mysql.createPool({
  host:'mysql',
  user:'root',
  password:'root',
  database:'countries'
})
app.use(cors())

connection.query("SELECT 1",(err, result)=>{
  err? console.error(err):console.log("Connect to database successfullly");
})

app.get('/api', (req, res) => {
    var sql = "SELECT * FROM "+`${req.query.table}`;
    connection.query(sql, function(err, results) {
      if (err) throw err;
      res.send(results);
    });
  });
  app.get('/api/columns', (req, res) => {
    var sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '"+`${req.query.table}`+"' ORDER BY ORDINAL_POSITION";
    connection.query(sql, function(err, results) {
      if (err) throw err;
      res.send(results);
    });
  });

app.listen(port, () => console.log(`Listening on port ${port}`));
