const btniniciarSesion = document.getElementById("start-session");
btniniciarSesion.addEventListener("click", () => {
  validarUsuario();
});

const btnCalendar = document.getElementById("start-session");
btnCalendar.addEventListener("click", () => {
  validarUsuario();
});

function getLanding(nombre, apellido) {
  const url = `frmLanding.html?nombre=${encodeURIComponent(nombre)}&apellido=${encodeURIComponent(apellido)}`;
  window.location.href = url;
}

function getMenus(nombre, apellido) {
  const url = `frmMenus.html?nombre=${encodeURIComponent(nombre)}&apellido=${encodeURIComponent(apellido)}`;
  window.location.href = url;
}

function cargarFormularioLanding() {
  fetch('frmLanding.html')
      .then(response => response.text())
      .then(html => {
          document.body.innerHTML = html;

          // Al cargar el formulario, llama a obtenerDatosUsuario y coloca los datos en los campos
          const userDetails = obtenerDatosUsuario(data.idCliente);
          document.getElementById('nombre').value = userDetails.datos.Nombre;
          document.getElementById('apellido').value = userDetails.datos.Apellido;
      })
      .catch(err => console.error('Error al cargar el formulario:', err));
}

// Función para redirigir a otro formulario con datos en la URL
function redirigirConDatos(nombre, apellido) {
  const url = `frmLanding.html?nombre=${encodeURIComponent(nombre)}&apellido=${encodeURIComponent(apellido)}`;
  window.location.href = url;
  const valorDeParraffo = document.getElementById('welcome-message-name-display').value;
  console.log(valorDeParraffo)
  
 // mostrarBienvenida(nombre, apellido)
}

//Valida si usuario = True y mantiene datos segun ID. 
async function validarUsuario() {
  const dniIngresado = document.getElementById('dni').value;
  const claveIngresada = document.getElementById('clave').value;

  if (!dniIngresado || !claveIngresada) return;

  const requestBody = { dni: dniIngresado, clave: claveIngresada };
  try {
    const res = await fetch('/api/v1/login', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(requestBody),
    });

    if (!res.ok) throw new Error('Error en la solicitud');
    const data = await res.json();

    if (data.usuario === true) {
      const userDetails = await obtenerDatosUsuario(data.idCliente);
      redirigirConDatos(userDetails.datos.Nombre, userDetails.datos.Apellido);
    }
  } catch (error) {
    console.error('Error al validar el usuario:', error);
    document.getElementById('mensaje').textContent = "Error al validar el usuario.";
  }
}

async function obtenerDatosUsuario(idCliente) {
  try {
    const response = await fetch(`/api/v1/cliente/${idCliente}`, { method: 'GET', headers: { 'Content-Type': 'application/json' } });
    if (!response.ok) throw new Error('Error al obtener los detalles del usuario');

    const userDetails = await response.json();
    return userDetails;
  } catch (error) {
    console.error('Error en obtenerDatosUsuario:', error);
    return null;
  }
}

function mostrarBienvenida(nombre, apellido) {
  const usuarioParagraph = document.getElementById('welcome-message-name-display');
  usuarioParagraph.insertAdjacentText("HOLA PADRE")
 /*  usuarioParagraph.value = `¡Bienvenido, ${nombre} ${apellido}!`; */
}
