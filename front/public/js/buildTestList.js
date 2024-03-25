const testMode = document.querySelector('meta[name="test-mode"]').getAttribute('content') === 'true';
const ITEMS_PER_PAGE = testMode ? 1 : 15;

const buildTestList = async (tests, currentPage) => {
    window.currentPage = currentPage;

    const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
    const endIndex = startIndex + ITEMS_PER_PAGE;
    const testsForCurrentPage = tests.slice(startIndex, endIndex);

    const table = document.querySelector('.table-list-model').cloneNode(true);
    const tbody = table.querySelector('tbody');
    table.classList.remove('table-list-model');
    document.getElementById('tables-list').innerHTML = '';

    tbody.innerHTML = testsForCurrentPage.map((test, idx) => {
        return `
            <tr class="row-${idx}" data-token="${test.result_token}">
                <td>${test.result_token}</td>
                <td>${test.result_date.replace(/-/g, "/")}</td> 
                <td>${test.patient.name}</td>
                <td>${test.patient.cpf}</td>
                <td>${test.doctor.name}</td>
                <td>${test.doctor.crm}/${test.doctor.crm_state}</td>
            </tr>
        `;
    }).join('');

    document.querySelector('#tables-list').appendChild(table)

    buildPaginationControls(tests.length, currentPage);
};

const buildPaginationControls = (totalItems, currentPage) => {
    const totalPages = Math.ceil(totalItems / ITEMS_PER_PAGE);
    const paginationContainer = document.createElement('div');
    paginationContainer.classList.add('pagination-controls');

    for (let i = 1; i <= totalPages; i++) {
        const pageButton = document.createElement('button');
        pageButton.innerText = i;
        pageButton.addEventListener('click', () => buildTestList(window.testsCache, i));
        
        if (currentPage === i) {
            pageButton.classList.add('active-page');
        }

        paginationContainer.appendChild(pageButton);
    }

    document.querySelector('#tables-list').appendChild(paginationContainer);
};

export default buildTestList;
