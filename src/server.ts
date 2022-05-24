import express from "express";

const port = 4000;
const app = express();

app.get("/", (req, res) => {
  res.send("Server OK");
});

app.post("/mint", (req, res) => {});

app.listen(port, () => {
  console.log(`App is listening on port: ${port}`);
});
