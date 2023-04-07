
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
    host: 'nguyen_db', // the host name MYSQL_DATABASE: node_mysql
    user: 'root', // database user MYSQL_USER: MYSQL_USER
    password: '12345678', // database user password MYSQL_PASSWORD: MYSQL_PASSWORD
    database: 'db' // database name MYSQL_HOST_IP: mysql_db
  })

  app.get('/data/:table', (req, res) => {
    let table = req.params.table;
    const SelectQuery = " SELECT * FROM " + table;
    console.log(SelectQuery)
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });

  app.get('/countries', (req, res) => {
    const SelectQuery = " SELECT * FROM countries";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });
  
  app.get('/countinents', (req, res) => {
    const SelectQuery = " SELECT * FROM countinents";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });

  app.get('/country_languages', (req, res) => {
    const SelectQuery = " SELECT * FROM country_languages";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });

  app.get('/country_stats', (req, res) => {
    const SelectQuery = " SELECT * FROM country_stats";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });

  app.get('/languages', (req, res) => {
    const SelectQuery = " SELECT * FROM languages";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });

  app.get('/regions', (req, res) => {
    const SelectQuery = " SELECT * FROM regions";
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })

  });
  app.get('/', (req, res) => {
    res.send("WELLCOME TO MY HOME PAGE")
   });

//   SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema = 'db'

app.get('/api/table', (req, res) => {
    const SelectQuery = " SELECT TABLE_NAME FROM information_schema.tables WHERE table_schema = 'db'";
    console.log(SelectQuery)
    db.query(SelectQuery, (err, result) => {
      res.send(result)
    })
  });


