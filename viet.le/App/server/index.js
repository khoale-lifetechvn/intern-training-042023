
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
const PORT = 3001;
app.use(cors())
app.use(express.json())
app.use(express.urlencoded({ extended: true }));

app.listen(PORT, (error) =>{
    if(!error)
        console.log("Server is Successfully Running, and App is listening on port "+ PORT)
    else 
        console.log("Error occurred, server can't start", error);
    }
);

const db = mysql.createPool({
    host: 'localhost', // the host name MYSQL_DATABASE: node_mysql
    user: 'root', // database user MYSQL_USER: MYSQL_USER
    password: '12345678', // database user password MYSQL_PASSWORD: MYSQL_PASSWORD
    database: 'newdatabase' // database name MYSQL_HOST_IP: mysql_db
  })

  app.get('/', (req, res) => {
    const SelectQuery = " SELECT * FROM regions";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })

  });