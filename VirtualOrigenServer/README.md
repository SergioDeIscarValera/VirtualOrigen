# VirtualOrigen Server

VirtualOrigen Server es la aplicación encargada de gestionar la lectura de datos del inversor, la gestión de llamar mediante MQTT a los dispositivos inteligentes cuando se requiera y gestionar las notificaciones.

## Descripción

La parte servidro se puede dividir en dos partes:

- La parte de lectura de datos del inversor.
- La parte de gestión de llamadas a dispositivos inteligentes.

### Lectura de datos del inversor

La lectura de datos del inversor se realiza mediante un script que se ejecuta cada 5 minutos. Este script se encarga de leer los datos de un fichero que genera un python. Este fichero tine la información en el siguiente formato:

```
<Fecha> <Hora> <Potencia> <Energía> <Energía acumulada>
```
