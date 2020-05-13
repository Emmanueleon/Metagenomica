# Metagenomica
Este repositorio contiene un flujo de trabajo para la tarea 8 de la clase Bioinformática CL-MX 2020. Se tienen 3 carpetas. 

1. **bin**: Contiene 2 scripts  para correr el pipeline de AMPtk y la generación de resultados (Se detallan en la siguiente sección). 
2. **data**: Posterior a correr el pipeline se genera un archivo de la taxonomía de las muestras en formato.biom, este será el input para el flujo de trabajo en R. 
3. **output**:Contiene las gráficas generadas en ggplot (Filos presentes en las muestras, alfa diversidad y distancia euclidiana), además de un archivo de texto con los datos de las muestras y la diversidad alfa por las metricas de Fisher y observada. 

## Scripts
En la carpeta bin se encuentran dos scripts: 

El primero es el análisis para 24 muestras de suelo rizosférico recolectado en sitios de bosque nativo **(N)** y mixto **(M)** de dos géneros de árboles, Quercus **(Q)** y Juniperus **(J)**. Cada muestra tiene un archivo fasta con las secuencias Forward (R1) y con las secuencias Reverse (R2). La primera parte del worflow es utilizar el programa AMPtk para el limpiado, podado, filtrado y asignación de OTUs a las secuencias de las muestras.   

Posteriormente el *output* del programa AMPkt, contiene un archivo .biom que contiene 3 archivos, la tabla de OTU, la Tabla de taxa y el archivo de las muestras, este archivo .biom alimeta el segundo script que es corrido en R.   

Utilizando los paquetes de `phyloseq`,`vegan`y `ggplot`se estima la diveridad alfa utilizando las metricas de observación y de Fisher. Se realiza un análisis estadístico ANOVa entre ambas metricas para el caso de los distintos tratamientos y huéspedes. Finalmente, se estima la diversidad beta, basandose en una tabla de disimilitud empleando escalamiento multidimensional no métrico por sus siglas en inglés (NMDS).   

**Nota**: Los detalles de cada script se encuentran dentro del mismo. 

## Resultados
A partir de los datos generados con respecto a utilizar como parámetro de longitud mínima 300 (tutorial) o 200 (tarea) si tiene un importante efecto en la composición de los microorganismos presentes. El número de reads es mayor al utilizar como parámetro un mínimo de longitud de 200 para todos los casos (tratamiento vs hospedero). 

A nivel el filo, podemos observar que tanto para el tratamiento como para el hospedero, la muestras utilizando un mínimo de longitud de 200 pb se tiene una mayor abundancia del filo Ascomycota, presentandose en mayor abundancia en Juniperus. En cuanto a las muestras generadas con una longitud mínima de 300 pb se encuentra en mayor abundacia el filo Basidiomycota. 

Para los psoteriores análisis para ambos parámetros de longitud (200 y 300 pb) se utilizaron las tablas generadas a partir de la función `decostand`del paquete ***vegan***. Similar a los resultados previamente mencionados, se observa que los datos provenientes del archivo .biom utilizando la longitud de 300 los valores de diversidad por las métricas de Fisher y Observada son menores, a comparación de los valores presentes en el archivo .biom generado utilizando el parametro de 200 pb.

**Nota**: Las tablas se encuentran en la carpeta *output*, se encuentran como formatos .tsv. 

De acuerdo a las gráficas generadas a partir de los datos de las tablas de presencia- ausencia, se muestra que Querceus muestra una mayor diversidad alfa por Fisher y por Observada a comparación de Juniperus y por tratamiento, la mustra de suelo mixto es el que contiene más diversidad tanto para Querceus como para Juniperus, sin embargo, estadísticamente no se muestra diferencia significativa entre las métricas, esto quizás es debido a la cantidad de las muestras analizadas. Entre los datos obtenidos con 200 pb se tienen más datos que con el parámetro 300, ya que en este último no existieron valores para la métrica de Fisher en el caso del huésped Quercus. 

Finalmente los resultados obtenidos de B diversidad, fue mejor utilizar una longitud de 200, ya que se muestran más datos, sin embargo para el caso de ambos no existe una diferencia significativa entre los distintos tratamientos ni tipo de huésped. 

Se puede concluir que al utilizar un parámetro diferente como la longitu de la secuencia en el preprocesamiento de las lecturas generadas por secuenciación, usar una longitud de 200 pb permíte una obtención de más datos, a diferencia de utilizar un parámetro de longitud de 300 pb.Como se observó, utilizar diferentes parámetros si modifica el análisis bioinformático, esto se pudo observar en la gráfica e abundancia a nivel de filo. Finalmente debido a la cantidad de datos obtenidos no se puede presentar diferencias estadísticas entre las diversidades alfa utilizando dos diferentes métricas, así como tampoco una diferencia entre la diversidad b de las muestras.  
