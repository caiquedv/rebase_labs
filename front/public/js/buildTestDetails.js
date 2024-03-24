import fetchData from "./fetchData.js";
import listeners from './listeners.js';

const buildTestDetails = async (token) => {
    let test = null
    try {
        test = await fetchData(`/fetch/${token}`);
        test = test instanceof Array ? test[0] : test;
        if (test.error) {
            alert(test.error);
            return;
        }
    } catch (error) {
        console.error(`error when building test details ${error}`)
        return;
    }
    
    document.getElementById('tables-list').innerHTML = '';
    const table = document.querySelector('.table-details-model').cloneNode(true);
    table.classList.remove('table-details-model');

    table.querySelector('#doctor').innerHTML = `
        Doctor: ${test.doctor.name} <br>
        CRM: ${test.doctor.crm}/${test.doctor.crm_state}
    `;
    table.querySelector('#patient').innerHTML = `
        Patient: ${test.patient.name} <br>
        CPF: ${test.patient.cpf} <br>
        Date of birth: ${test.patient.birthdate.replace(/-/g, "/")} <br>
        Address: ${test.patient.address} - ${test.patient.city} / ${test.patient.state}
    `;
    table.querySelector('#exam').innerHTML = `
        Token: ${test.result_token} <br>
        Result Date: ${test.result_date.replace(/-/g, "/")} <br>
    `;

    const tbody = table.querySelector('tbody');

    tbody.innerHTML = test.tests.map(test => {
        const [min, max] = test.limits.split('-');
        
        return `
            <tr class="test-details">
                <td>${test.type}</td>
                <td>${min} to ${max}</td>
                <td>${test.results}</td>
            </tr>
        `;
    }).join('');

    const list = document.getElementById('tables-list')
    const divBackButton = document.createElement('div');
    const backButton = document.createElement('button');
    
    backButton.innerText = 'Back to list';

    list.appendChild(table)
    divBackButton.appendChild(backButton)
    list.insertBefore(divBackButton, list.firstChild);
    
    listeners.backToList(backButton);
};

export default buildTestDetails;