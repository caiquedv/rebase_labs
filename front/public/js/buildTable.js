const buildTable = async (obj, idx) => {
    const table = document.querySelector('.table-model').cloneNode(true);
    table.classList.remove('table-model');
    table.classList.add(`table-${idx}`)

    table.querySelector('#doctor').innerHTML = `
        Doctor: ${obj.doctor.name} <br>
        CRM: ${obj.doctor.crm}-${obj.doctor.crm_state}
    `;
    table.querySelector('#patient').innerHTML = `
        Patient: ${obj.patient.name} <br>
        CPF: ${obj.patient.cpf} <br>
        Date of birth: ${obj.patient.birthdate.replace(/-/g, "/")} <br>
        Address: ${obj.patient.address} - ${obj.patient.city} / ${obj.patient.state}
    `;
    table.querySelector('#exam').innerHTML = `
        Token: ${obj.result_token} <br>
        Result Date: ${obj.result_date.replace(/-/g, "/")} <br>
    `;

    const tbody = table.querySelector('tbody');

    tbody.innerHTML = obj.tests.map(test => {
        const [min, max] = test.limits.split('-');
        
        return `
            <tr>
                <td>${test.type}</td>
                <td>${min} to ${max}</td>
                <td class="${outLimitClass}">${test.results}</td>
            </tr>
        `;
    }).join('');

    document.querySelector('#tables-list').appendChild(table)
};

export default buildTable;