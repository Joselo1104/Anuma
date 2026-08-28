function toggleForm() {
    const container = document.getElementById('formContainer');
    container.style.display = 'block';
    window.scrollTo({ top: 0, behavior: 'smooth' });
}

function cancelarForm(currentUrlParams) {
    // Si estamos editando (hay ID en URL), recargar sin ID para limpiar
    if (window.location.search.includes('edit_id')) {
        // Redirigir a la misma categoria pero sin edit_id
        // currentUrlParams debería ser algo como "cat=1"
        const params = new URLSearchParams(window.location.search);
        const cat = params.get('cat') || 1;
        window.location.href = 'Aproductos.php?cat=' + cat;
    } else {
        document.getElementById('formContainer').style.display = 'none';
    }
}

// Lógica de Stock para Ropa
function mostrarBloqueStock() {
    const tipo = document.getElementById('tipoStockSelect');
    if (!tipo) return; // Si no existe (porque estamos en Papelería/Hogar), salir.

    const val = tipo.value;

    // Ocultar todos los específicos de ropa
    ['stock_unico', 'stock_ropa', 'stock_calzado', 'stock_pantalones'].forEach(id => {
        const el = document.getElementById(id);
        if (el) el.classList.add('hidden');
    });

    // Mostrar el seleccionado
    if (val === 'unico') {
        const el = document.getElementById('stock_unico');
        if(el) el.classList.remove('hidden');
    }
    if (val === 'ropa') {
        const el = document.getElementById('stock_ropa');
        if(el) el.classList.remove('hidden');
    }
    if (val === 'calzado') {
        const el = document.getElementById('stock_calzado');
        if(el) el.classList.remove('hidden');
    }
    if (val === 'pantalones') {
        const el = document.getElementById('stock_pantalones');
        if(el) el.classList.remove('hidden');
    }
}

// Función de inicialización que llamaremos desde el PHP
function initProductos(isRopaCategory) {
    if (isRopaCategory) {
        mostrarBloqueStock();
    }
}

function getProductCellValue(row, column) {
    const cell = row.querySelector(`td[data-column="${column}"]`);
    if (!cell) return '';

    const text = cell.textContent.trim();

    if (column === 'precio') {
        return parseFloat(text.replace(/[$,]/g, '')) || 0;
    }

    if (column === 'stock') {
        return parseInt(text.replace(/[^0-9-]/g, ''), 10) || 0;
    }

    if (column === 'estado') {
        return text.toLowerCase().includes('activo') ? 1 : 0;
    }

    if (column === 'id') {
        return parseInt(text.replace(/[^0-9]/g, ''), 10) || 0;
    }

    return text.toLowerCase();
}

function initProductTableSorting() {
    const table = document.getElementById('productosTable');
    if (!table) return;

    const headers = table.querySelectorAll('thead .sortable-header');
    if (!headers.length) return;

    let currentSort = { column: null, direction: 'asc' };

    headers.forEach((header) => {
        header.addEventListener('click', () => {
            const column = header.getAttribute('data-column');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr')).filter((row) => !row.querySelector('.no-data'));

            if (!column || rows.length < 2) return;

            const direction = currentSort.column === column && currentSort.direction === 'asc' ? 'desc' : 'asc';
            currentSort = { column, direction };

            headers.forEach((item) => item.classList.remove('sort-active'));
            header.classList.add('sort-active');

            rows.sort((a, b) => {
                const aValue = getProductCellValue(a, column);
                const bValue = getProductCellValue(b, column);
                let result = 0;

                if (typeof aValue === 'number' && typeof bValue === 'number') {
                    result = aValue - bValue;
                } else {
                    result = String(aValue).localeCompare(String(bValue), 'es', { sensitivity: 'base' });
                }

                return direction === 'asc' ? result : -result;
            });

            rows.forEach((row) => tbody.appendChild(row));
        });
    });
}

document.addEventListener('DOMContentLoaded', function () {
    if (typeof initProductos === 'function') {
        initProductos(window.location.search.includes('cat=1'));
    }

    initProductTableSorting();
});