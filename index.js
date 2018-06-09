var express = require('express');
var faker = require('faker');
var router = express.Router();
var pg = require('pg');

const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'postgres',
    port: 5432,
});

const query = 'SELECT * FROM users;';
const queryUsersCount = 'SELECT COUNT(email) AS usersCount FROM users';
var usersCount;

for (var i = 0;i < 480;i++) {
    var userEmail = "'"+faker.internet.email()+"'";
    var insertUser = 'INSERT INTO users(email) VALUES (' + userEmail +')';
    console.log(insertUser);
    pool.query(insertUser, (err) => {
        if(err) {
            console.log(err);
            throw err;
        } else {
            console.log('INSERT INTO users OK');
        }
    })
}

pool.query(queryUsersCount, (err, res) => {
    if(err) {
        console.log(err.stack)
    } else {
        console.log(res.rows[0].userscount);
        usersCount = res.rows[0].userscount;
    }
});

pool.query(query, (err, res) => {
    if(err) {
        console.log(err.stack)
    } else {
        for (var i = 0; i<usersCount; i++){
            console.log(res.rows[i].email);
            console.log(res.rows[i].created_at);
        }
    }
});

pool.end();

function generateEmail() {
    console.log(faker.internet.email());
}

function generateAdress(){
    console.log(faker.address.city());
}

function generatePastDate(){
    console.log(faker.date.past());
}

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

module.exports = router;
