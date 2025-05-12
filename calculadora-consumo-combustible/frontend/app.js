document.getElementById('calcular').addEventListener('click', function() {
    const velocidad = parseFloat(document.getElementById('velocidad').value);
    const peso = parseFloat(document.getElementById('peso').value);
    const terreno = document.getElementById('terreno').value;
    const distancia = parseFloat(document.getElementById('distancia').value);

    const resultadoDiv = document.getElementById('resultado');

    if (isNaN(velocidad) || velocidad < 30 || velocidad > 180) {
        resultadoDiv.innerHTML = "<span class='error'>La velocidad debe estar entre 30 y 180 km/h.</span>";
        return;
    }

    if (isNaN(peso) || peso < 900) {
        resultadoDiv.innerHTML = "<span class='error'>El peso debe ser al menos 900 kg.</span>";
        return;
    }

    if (isNaN(distancia) || distancia <= 0) {
        resultadoDiv.innerHTML = "<span class='error'>La distancia debe ser un número positivo.</span>";
        return;
    }

    const datos = {
        velocidad: velocidad,
        peso: peso,
        terreno: terreno,
        distancia: distancia
    };

    // Hacer la solicitud al servidor
    fetch('http://localhost:5000/calcular', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(datos)
    })
    .then(response => response.json())
    .then(data => {
        let resultadoHTML = `<strong>Consumo estimado:</strong> ${data.consumo_estimado} litros/100 km<br>`;
        resultadoHTML += `<strong>Gasto estimado:</strong> ${data.gasto_estimado} COP`;
        resultadoDiv.innerHTML = resultadoHTML;
    })
    .catch(error => {
        console.error('Error:', error);
        resultadoDiv.innerHTML = "<span class='error'>Error al obtener los resultados. Verifique la consola.</span>";
    });
});z