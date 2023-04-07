
const express = require('express');
const mysql = require('mysql2');
const cors = require('cors')
const app = express();

const connection = mysql.createConnection({
  host: 'mysql',
  user: 'Minh',
  password: 'Tuongminh2001@',
  database: 'my_database'
});
app.use(cors())

app.get('/:table/columns',(req, res)=>{
  const table = req.params.table
  const query = "select COLUMN_NAME as name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME= '" + `${table}` +"'"
  connection.query(query,(err,results)=>{
    if (err) throw error;
    res.send(results);
  })
})

app.get('/:table' , (req, res) => {
  const table = req.params.table
  const query = "select * from "+ `${table}`
  console.log(query);
  connection.query(query,(err, results)=>{
    if (err) throw error;
    res.send(results);
  })
})
app.get('/', (req, res) => {
  res.send('Hello Minh');
});

app.listen(3001, () => {
  console.log('Server started on port 3001');
});
