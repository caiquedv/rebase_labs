document.querySelector('.csv-upload').addEventListener('submit', async (e) => {
  e.preventDefault();

  const fileInput = document.getElementById('csvFile');
  const file = fileInput.files[0];

  const formData = new FormData();
  formData.append('csvFile', file);

  try {
    const response = await fetch('/fetch/csv', {
      method: 'POST',
      body: formData
    });

    if (response.ok) {
      console.log('CSV file uploaded successfully!');
    } else {
      console.error('Failed to upload CSV file:', response.statusText);
    }
  } catch (error) {
    console.error('Error uploading CSV file:', error);
  }
});

const showList = async () => {
  try {
    const data = await fetchData('/fetch');    
    
    const main = document.querySelector('main');
    const ul = document.createElement('ul');

    data.forEach(function(exam) {
    main.appendChild(createList(ul, exam));
	});
  } catch (error) {
	  console.error('Error fetching data:', error);
  }
 };
 
 document.querySelector('.search-token').addEventListener('submit', async (e) => {
  e.preventDefault();
 
  try {
    const token = e.target[0].value;
    const dataPerToken = await fetchData(`/fetch/${token}`);
    
    const node = document.querySelector("ul");
    if (node.parentNode) {
    node.parentNode.removeChild(node);
    }
    
    const main = document.querySelector('main');
    const ul = document.createElement('ul');

    main.appendChild(createList(ul, dataPerToken));
  } catch (error) {
	  console.error('Error fetching data:', error);
  }
 });
 
 const fetchData = async (url) => {
  try {
    const response = await fetch(url);
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error fetching data:', error);
    throw error; 
  }
 };

const createList = (parent, exam) => {
  addListItem(parent, `Token: ${exam.result_token}`);
  addListItem(parent, `Result Date: ${exam.result_date}`);
  addListItem(parent, `Patient: ${exam.patient.name}`);
  addListItem(parent, `CPF: ${exam.patient.cpf}`);
  addListItem(parent, `City: ${exam.patient.city}`);
  addListItem(parent, `State: ${exam.patient.state}`);
  addListItem(parent, `Address: ${exam.patient.address}`);
  addListItem(parent, `Birthdate: ${exam.patient.birthdate}`);
  addListItem(parent, `Doctor: ${exam.doctor.name}`);
  addListItem(parent, `CRM: ${exam.doctor.crm}`);
  addListItem(parent, `CRM State: ${exam.doctor.crm_state}`);

  const testList = document.createElement('ul');
  exam.tests.forEach(function(test) {
    addListItem(testList, `Type: ${test.type}`);
    addListItem(testList, `Type Limits: ${test.limits}`);
    addListItem(testList, `Type Results: ${test.results}`);
  });

  parent.appendChild(testList);
  return parent;
};

const addListItem = (parent, text) => {
  const li = document.createElement('li');
  li.innerHTML = `<strong>${text}</strong>`;
  parent.appendChild(li);
};

showList();