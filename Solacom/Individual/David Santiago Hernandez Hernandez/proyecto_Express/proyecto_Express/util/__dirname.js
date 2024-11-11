import { fileURLToPath } from "url";
import path, { join } from "path";

const __filename = fileURLToPath(import.meta.url);
//Configuración de directorio raiz carptea SRC
const __dirname = path.dirname(join(__filename,"../")); 

export { __dirname };