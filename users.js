var express = require('express');
var router = express.Router();
const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'postgres',
    password: 'postgres',
    port: 5432,
});

var usersCount;

/* GET users listing. */
router.get('/', function(req, res, next) {

    pool.query('SELECT COUNT(*) FROM users AS count;', (error, results) => {
        if (error) {
            console.log(error);
            throw error;
        } else {
            usersCount = results.rows[0].count;
            console.log(usersCount.toString());
        }
    });
    res.render('users', { userNumber: usersCount });
});

module.exports = router;
