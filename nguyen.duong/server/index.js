const express = require('express')
const app = express()
const cors = require('cors');
const port = 3001
const mysql = require('mysql2')

app.use(cors());

app.get('/', (req, res) => {
    res.send('Hello World, This is my Home Page!')
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})

const connection = mysql.createConnection({
    host: 'nguyen_db',
    user: 'root', //
    password: '12345678', //
    database: 'db_docker',
})
connection.connect((err) => {
    if (err) {
        console.log(err)
        return
    }
    console.log('Database connected')
})
module.exports = connection

app.get('/table/:name', function (req, res) {
    let table_name = req.params.name;
    if (!table_name) {
        return res.status(400).send({ error: true, message: 'Please provide table name' });
    }
    connection.query('SELECT * FROM ' + table_name, function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: table_name + ' list.' });
    });
});

app.get('/table_columns/:name', function (req, res) {
    let table_name = req.params.name;
    if (!table_name) {
        return res.status(400).send({ error: true, message: 'Please provide table name' });
    }
    connection.query(`SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '${table_name}'`, table_name, function (error, results, fields) {
        if (error) throw error;
        return res.send({ error: false, data: results, message: table_name + ' list.' });
    });
});

app.get('/table', function (req, res) {
    connection.query(`SHOW TABLES`, function (error, results, fields) {
        if (error) throw error;
        return res.send(results);
    });
});