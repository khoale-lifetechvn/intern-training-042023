require("dotenv").config();
const express = require("express");
const cors = require("cors");
//new
const pool = require('./db');

const app = express();

var corsOptions = {
  origin: "http://localhost:8081"
};



app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(express.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(express.urlencoded({ extended: true }));

const db = require("./app/models");

db.sequelize.sync();
// // drop the table if it already exists

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Welcome to bezkoder application." });
});

require("./app/routes/turorial.routes")(app);

// set port, listen for requests
const PORT = process.env.NODE_DOCKER_PORT || 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}.`);
});

app.get('/languages', (req, res) => {
  pool.query('SELECT * FROM languages', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

app.get('/continents', (req, res) => {
  pool.query('SELECT * FROM continents', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

app.get('/country_language', (req, res) => {
  pool.query('SELECT * FROM country_language', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

app.get('/country_stats', (req, res) => {
  pool.query('SELECT * FROM country_stats', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});

app.get('/regions', (req, res) => {
  pool.query('SELECT * FROM regions', (err, rows) => {
    if (err) throw err;
    res.json(rows);
  });
});



