import express from "express";
import { mint } from "./routes/routes";

const port = 4000;
const app = express();

app.get("/", (req, res) => {
  res.send("Server OK");
});

app.post("/mint", mint);

app.listen(port, () => {
  console.log(`App is listening on port: ${port}`);
});
