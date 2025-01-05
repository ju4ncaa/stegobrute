# StegoBrute

Herramienta de fuerza bruta para extraer información oculta en imágenes utilizando Steghide, este script de Bash automatiza el proceso de búsqueda de contraseñas utilizando un diccionario y extrae los datos ocultos de imágenes en formatos JPG o JPEG.

## Descargar stegobrute

```
git clone https://github.com/ju4ncaa/stegobrute.git
```

## Notas

* El script requiere privilegios de superusuario (root) para instalar herramientas o realizar ciertas acciones.
* Si la imagen no tiene una extensión válida (JPG o JPEG), el script terminará con un mensaje de error.
* El diccionario de contraseñas debe ser un archivo de texto con una contraseña por línea.

## Uso

### Sintaxis

```bash
./stegobrute.sh <imagen> <diccionario> <archivo_salida>
```
### Ejemplo de uso

![imagen](https://github.com/user-attachments/assets/6ca5395f-7768-4a2e-a2dd-97a22cd6ed6f)

![imagen](https://github.com/user-attachments/assets/ad0e6d5e-8a88-4463-9c2c-d33b2d9bdd3b)

![imagen](https://github.com/user-attachments/assets/1ca1cd3b-12cd-4d42-8cb7-905fef7f2be3)
