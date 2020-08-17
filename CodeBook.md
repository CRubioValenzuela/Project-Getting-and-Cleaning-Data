Fusiona los conjuntos de entrenamiento y prueba para crear un conjunto de  
datos. En este paso, leemos los datos de la carpeta UCI HAR Dataset para el 
conjunto de datos de entrenamiento y prueba. Creamos el conjunto de datos de 
entrenamiento y prueba combinando los datos de la etiqueta, los datos del 
sujeto y los datos de las características de "y_train.txt", 
"subject_train.txt" y "X_train.txt". Combinamos el tren y los datos de prueba 
en un conjunto de datos llamado data_merged. Asignamos los nombres de las 
características a la variable de columnas de características usando la 
información en "features.txt".

Extrae solo las medidas de la desviación estándar y media de cada medida. 
Seleccionamos la columna que contiene solo la información media y estándar y 
almacenamos el nuevo marco de datos en data_measured.

Utiliza nombres de actividad descriptivos para nombrar las actividades en el 
conjunto de datos. Cambiamos el nombre del índice de actividad a nombres de 
actividad después de "activity_labels.txt".

Etiqueta adecuadamente el conjunto de datos con nombres de variables 
descriptivos. Cambiamos el nombre de la variable al nombre completo para que 
los nombres sean más legibles.

A partir del conjunto de datos del último paso, crea un segundo conjunto de 
datos ordenado e independiente con el promedio de cada variable para cada 
actividad y cada tema llamado "tidy_data.txt".
