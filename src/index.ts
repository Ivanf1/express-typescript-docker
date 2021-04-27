import express, { Request, Response } from "express";

const app = express();

app.get("/", (_request: Request, response: Response) => {
  response.send("Hello!");
});

const port = 4000;

app.listen(port, () => {
  console.log("Server started");
});
