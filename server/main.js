// use express for json file and mysql for db
const express = require("express");
const mysql = require("mysql2/promise");

let db = null;
const app = express();

app.use(express.json());

app.post('/create-user', async(req, res, next)=>{
  const name = req.body.name;

  // add user by sending a query to the db
  await db.query("INSERT INTO users (name) VALUES (?);", [name]);

  res.json({status:"OK"});
  next();
});

// TODO: cannot get user lists.
app.get('/users', async (req, res, next) => {
  // load all user lists from db
  const [rows] = await db.query("SELECT * FROM users;");

  res.json(rows);
  next();
});

// Asynchrony process
async function main(){
  try {
    db = await mysql.createConnection({
      host:"host",
      user: "user",
      password: "password",
      database: "dbname",
      timezone: "+00:00",
      charset: "utf8mb4_general_ci",
    });
  } catch(e) {
    console.log(e);
  }

  app.listen(8000);
}

main();
