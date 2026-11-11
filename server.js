const express = require("express");
const knex = require("knex");
const app = express();
const port = 8080;

const database = knex({
  client: "mysql2",
  connection: {
    host: "localhost",
    port: "3306",
    user: "root",
    password: "",
    database: "bookings",
  },
});

app.get("/api/hotels", async (req, res) => {
  const data = await database("hotels").select("*");
  return res.status(200).json(data);
});

app.get("/api/bookings/by-hotel/:hotel_id", async (req, res) => {
  const { hotel_id } = req.params;

  const data = await database("bookings")
    .select("*")
    .where("hotel_id", hotel_id);
  return res.status(200).json(data);
});

app.get("/api/bookings/by-search/:search_word", async (req, res) => {
  const { search_word } = req.params;

  const data = await database("bookings")
    .join("hotels", "hotels.id", "bookings.hotel_id")
    .join("customers", "customers.email", "bookings.customer_email")
    .select("*")
    .where(function () {
      this.where("customers.first_name", "like", `%${search_word}%`)
        .orWhere("customers.last_name", "like", `%${search_word}%`)
        .orWhere("hotels.description", "like", `%${search_word}%`)
        .orWhere("hotels.name", "like", `%${search_word}%`);
    });

  return res.status(200).json(data);
});

app.put("/api/booking", (req, res) => {
  const { body } = req.body;

  const data = database("bookings")
    .where({
      customer_email: body.customer_email,
      hotel_id: body.hotel_id,
    })
    .update(body);

  if (data) {
    return res.status(200).json({ response: "siker??" });
  } else {
    return res.status(500).json({ response: "error " });
  }
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
