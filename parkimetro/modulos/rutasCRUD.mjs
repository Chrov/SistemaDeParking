import express from 'express';

import { controladorObtenerReserva, controladorObtenerReservas, controladorRegistrarReserva , controladorModificarReserva, controladorCancelarReserva} from "./reservas/controlador.reservas.mjs";
import { controladorComprobarLogin, controladorObtenerDatosCliente } from "./usuarios/controlador.usuarios.mjs";

const rutasCRUD = express.Router()

rutasCRUD.use('/api/v1', express.json())

rutasCRUD.get('/api/v1/reservas', controladorObtenerReservas) // listo
rutasCRUD.get('/api/v1/reservas/:id', controladorObtenerReserva) // listo 
rutasCRUD.post('/api/v1/reservas', controladorRegistrarReserva) // listo
rutasCRUD.put('/api/v1/reservas/:id', controladorModificarReserva) // listo
rutasCRUD.delete('/api/v1/reservas/:id', controladorCancelarReserva) // listo
rutasCRUD.post('/api/v1/login', controladorComprobarLogin) // listo
rutasCRUD.get('/api/v1/cliente/:idCliente', controladorObtenerDatosCliente)  

export default rutasCRUD
