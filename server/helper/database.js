const Sequelize = require('sequelize');
require('dotenv').config();

module.exports = {
    // Database Admin
    admin: new Sequelize(
        process.env.DB_NAME,
        process.env.DB_USER_ADMIN,
        process.env.DB_PASS_ADMIN,
        {
            host: '127.0.0.1',
            dialect: 'mssql'
        }
    ),
    // User
    user: new Sequelize(
        process.env.DB_NAME,
        process.env.DB_USER_NORMAL,
        process.env.DB_PASS_NORMAL,
        {
            host: '127.0.0.1',
            dialect: 'mssql'
        }
    ),
    // Non-Authorized User / Unregistered User
    basic: new Sequelize(
        process.env.DB_NAME,
        process.env.DB_USER_BASIC,
        process.env.DB_PASS_BASIC,
        {
            host: '127.0.0.1',
            dialect: 'mssql'
        }
    )
}