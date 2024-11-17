import {
    modeloObtenerUsuario, modeloObtenerDatosCliente
  } from "./modelo.usuarios.mjs";

  async function controladorComprobarLogin(req, res) {
    try {
      const { dni, clave } = req.body;

      const datos = await modeloObtenerUsuario(dni, clave);

      if (!dni || !clave) {
        return res.status(400).json({ usuario: false, mensaje: "DNI y clave son requeridos" });
      }
      
      if (datos.length > 0) {
        res.status(200).json({ idCliente: datos[0].idCliente, usuario: true });
      } else {
        res.status(404).json({ usuario: false });
      }
    } catch (error) {
      res.status(500).json({ usuario: false, mensaje: "Error en el servidor" });
    }
  }

  async function controladorObtenerDatosCliente(req, res) {
    try {
      const { idCliente } = req.params;
      console.log(idCliente)
      const datos = await modeloObtenerDatosCliente(idCliente);
      console.log(datos)

      if (datos != null) {
        res.status(200).json({ datos });
      } else {
        res.status(404).json({ mensaje: `No se encontraron datos del cliente con id ${idCliente}` });
      }
    } catch (error) {
      res.status(500).json({ mensaje: "Error en el servidor" });
    }
  }

  export {
    controladorComprobarLogin, controladorObtenerDatosCliente
  };