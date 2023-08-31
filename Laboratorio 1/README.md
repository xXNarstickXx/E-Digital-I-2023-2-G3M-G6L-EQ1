# Instalación de herramientas

- [Instalación de Miniconda](#instalación-de-miniconda)
- [Instalación de herramientas luego de instalar Miniconda](instalación-de-herramientas-luego-de-instalar-conda)

## Instalación de Miniconda
Miniconda es el gestor de paquetes y administrador de entornos de Python el cual usaremos en Linux.

Para ello se usó el siguiente código en la terminal: 

```bash
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  bash Miniconda3-latest-Linux-x86_64.sh
```
Luego de esto se verificó una correcta instalación de Miniconda obteniendo lo siguiente:

![L11](https://i.ibb.co/DW49nz6/1.png)
## Instalación de herramientas luego de instalar Conda

Las herramientas instaladas fueron las siguientes:

- GTKwave
- Graphviz
- Netlistsbg
- Iverilog
- Yosys

Y para ello se utilizaron los siguientes comandos en la terminal:

```bash
  conda install -c conda-forge gtkwave 
  conda install -c conda-forge graphviz
  conda install -c symbiflow netlistsvg
  conda install -c "litex-hub" yosys
  conda install -c "litex-hub" iverilog
```
Verificamos una instalación correcta para gtkwave:

[L12](https://i.ibb.co/S0NNJGS/2.png)

Se puede ver una instalacion sin errores para Graphviz:

[L13](https://i.ibb.co/GMHbwcW/3.png)
