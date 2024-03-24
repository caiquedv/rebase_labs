const buildTestList = async (tests) => {
    const table = document.querySelector('.table-list-model').cloneNode(true);
    const tbody = table.querySelector('tbody');
    table.classList.remove('table-list-model');

    tbody.innerHTML = tests.map((test, idx) => {
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
};

export default buildTestList;
