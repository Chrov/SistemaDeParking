import express from "express";
import rutasCRUD from "./modulos/rutasCRUD.mjs";

const app = express();
const PUERTO = 3000;

app.use(express.static("front"));
app.use(rutasCRUD);
app.listen(PUERTO, () => {
    console.log(`Servidor escuchando en el puerto ${PUERTO}`);
  });