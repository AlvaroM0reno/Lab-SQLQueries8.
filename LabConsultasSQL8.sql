-- 1. Clasifique las películas por duración (filtre las filas con nulos o ceros en la columna de duración). Seleccione solo el título, la longitud y la clasificación de las columnas en su salida.
SELECT title, length, RANK() OVER (ORDER BY length) AS ranking
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 2. Clasifique las películas por duración dentro de la ratingcategoría (filtre las filas con nulos o ceros en la columna de duración). En su salida, seleccione solo el título, la longitud, la calificación y la clasificación de las columnas.
SELECT title, length, rating,
	RANK() OVER (PARTITION BY rating ORDER BY length) AS ranking
FROM film
WHERE length IS NOT NULL AND length > 0;

-- 3. ¿Cuántas películas hay para cada una de las categorías en la tabla de categorías? Sugerencia : utilice una combinación adecuada entre las tablas "categoría" y "categoría_película".
SELECT 	c.name AS category, COUNT(fc.film_id) AS num_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name;

-- 4. ¿Qué actor ha aparecido en más películas? Sugerencia : puede crear una combinación entre las tablas "actor" y "actor de cine" y contar el número de veces que aparece un actor.
SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS num_films_appeared
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
ORDER BY num_films_appeared DESC
LIMIT 1;

-- 5. ¿Cuál es el cliente más activo (el cliente que ha alquilado más películas)? Sugerencia : utilice la combinación adecuada entre las tablas "cliente" y "alquiler" y cuente rental_id para cada cliente.
SELECT c.first_name, c.last_name, COUNT(r.rental_id) AS num_rentals
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY num_rentals DESC
LIMIT 1;

-- Bono : ¿Cuál es la película más alquilada? (La respuesta es La Hermandad del Balde).
-- Esta consulta puede requerir el uso de más de una declaración de unión. Darle una oportunidad. Hablaremos sobre consultas con múltiples declaraciones de unión más adelante en las lecciones.
-- Sugerencia : puede utilizar la unión entre tres tablas: "Película", "Inventario" y "Alquiler" y contar los identificadores de alquiler de cada película.
SELECT f.title AS most_rented_film, COUNT(*) AS num_rentals
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY num_rentals DESC
LIMIT 1;
