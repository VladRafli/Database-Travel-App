/**
 * Modules
 */

// Express
const express = require('express');
// Cors
const cors = require('cors');
// Dotenv
require('dotenv').config();
// Database Config
const conn = require('./helper/database')

/**
 * Global Variables
 */

// App Port
const PORT = process.env.PORT || 5000;
// App Startpoint
const app = express();

/**
 * Middlewares
 */

// Express Config
app.use(express.urlencoded({
    extended: true
}));
app.use(express.json());
// Cors
app.use(cors());
// Connect to admin level permission to Database (Temporary)
conn.admin.authenticate()
    .then(() => {
        console.log('Connection has been established successfully.');
        app.listen(PORT, () => {
            console.log(`Server is running on port ${PORT}`);
        });
    })
    .catch(e => {
        console.error(`Unable to connect to the database: ${e}`);
    });