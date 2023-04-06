const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const pool = require('./db');


const app = express();
app.use(cors());

app.use(bodyParser.json());

app.get('/country', (req, res) => {
  pool.query('SELECT * FROM languages', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

app.listen(3000, () => console.log('Server started on port 3000'));