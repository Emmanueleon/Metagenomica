# Metagenomica
Este repositorio contiene un flujo de trabajo para la tarea 8 de la clase Bioinformática CL-MX 2020. Se tienen 3 carpetas. 

1. **bin**: Contiene 2 scripts  para correr el pipeline de AMPtk y la generación de resultados (Se detallan en la siguiente sección). 
2. **data**: Posterior a correr el pipeline se genera un archivo de la taxonomía de las muestras en formato.biom, este será el input para el flujo de trabajo en R. 
3. **output**:Contiene las gráficas generadas en ggplot (Filos presentes en las muestras, alfa diversidad y distancia euclidiana), además de un archivo de texto con los datos de las muestras y la diversidad alfa por las metricas de Fisher y observada. 

## Scripts
En la carpeta bin se encuentran dos scripts: 

El primero es el análisis para 24 muestras de suelo rizosférico recolectado en sitios de bosque nativo **(N)** y mixto **(M)** de dos géneros de árboles, Quercus **(Q)** y Juniperus **(J)**. Cada muestra tiene un archivo fasta con las secuencias Forward (R1) y con las secuencias Reverse (R2). La primera parte del worflow es utilizar el programa AMPtk para el limpiado, podado, filtrado y asignación de OTUs a las secuencias de las muestras.   

Posteriormente el *output* del programa AMPkt, contiene un archivo .biom que contiene 3 archivos, la tabla de OTU, la Tabla de taxa y el archivo de las muestras, este archivo .biom alimeta el segundo script que es corrido en R. Utilizando los paquetes de `phyloseq`, `vegan`y `ggplot`se estima la diveridad alfa utilizando las metricas de observación y de Fisher. Se realiza un análisis estadístico ANOVa entre ambas metricas para el caso de los distintos tratamientos y huéspedes. Posterior se estima la diversidad beta, basandose en una tabla de disimilitud empleando escalamiento multidimensional no métrico por sus siglas en inglés (NMDS).   

**Nota**: Los detalles de cada script se encuentran dentro del mismo. 

## Resultados









