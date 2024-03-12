const fragment = new DocumentFragment();
const url = '/fetch';

const fetchData = async () => {
  try {
    const response = await fetch(url);
    const data = await response.json();    
    
    const ul = document.querySelector('ul');

    data.forEach(function(exam) {
      addListItem(ul, `Token: ${exam.result_token}`);
      addListItem(ul, `Result Date: ${exam.result_date}`);
      addListItem(ul, `Patient: ${exam.patient.name}`);
      addListItem(ul, `CPF: ${exam.patient.cpf}`);
      addListItem(ul, `City: ${exam.patient.city}`);
      addListItem(ul, `State: ${exam.patient.state}`);
      addListItem(ul, `Address: ${exam.patient.address}`);
      addListItem(ul, `Birthdate: ${exam.patient.birthdate}`);
      addListItem(ul, `Doctor: ${exam.doctor.name}`);
      addListItem(ul, `CRM: ${exam.doctor.crm}`);
      addListItem(ul, `CRM State: ${exam.doctor.crm_state}`);

      const test_ul = document.createElement('ul');
      exam.tests.forEach(function(test) {
        addListItem(test_ul, `Type: ${test.type}`);
        addListItem(test_ul, `Type Limits: ${test.limits}`);
        addListItem(test_ul, `Type Results: ${test.results}`);
      });

      ul.appendChild(test_ul);
      
    });
  } catch (error) {
    console.error('Error fetching data:', error);
  }
};

const addListItem = (parent, text) => {
  const li = document.createElement('li');
  li.innerHTML = `<strong>${text}</strong>`;
  parent.appendChild(li);
};

fetchData();
