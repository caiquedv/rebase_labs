const buildTable = async (obj) => {
    document.getElementById('doctor').innerHTML = `
        Doctor: ${obj.doctor.name} <br>
        CRM: ${obj.doctor.crm}-${obj.doctor.crm_state};
    `;
    document.getElementById('patient').innerHTML = `
        Patient: ${obj.patient.name} <br>
        CPF: ${obj.patient.cpf} <br>
        Date of birth: ${obj.patient.birthdate.replace(/-/g, "/")} <br>
        Endereço: ${obj.patient.address} - ${obj.patient.city} / ${obj.patient.state}
    `;
    document.getElementById('exam').innerHTML = `
        Token: ${obj.result_token} <br>
        Result Date: ${obj.result_date.replace(/-/g, "/")} <br>
    `;

    const tbody = document.querySelector('tbody');

    obj.tests.forEach(test => {
        const trModel = document.querySelector('.test-row-model').cloneNode(true);
        trModel.classList.remove('test-row-model');

        const [min, max] = test.limits.split('-');
        trModel.querySelector('.test-type').textContent = test.type;
        trModel.querySelector('.test-limits').textContent = `${min} to ${max}`;
        trModel.querySelector('.test-results').textContent = test.results;
        if (test.results < min || test.results > max) {
            trModel.querySelector('.test-results').classList.add('out-limit');
        }
        tbody.appendChild(trModel);
    });
};

export default buildTable;