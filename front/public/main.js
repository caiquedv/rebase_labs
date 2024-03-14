import fetchData from './fetchData.js';
import buildTable from './buildTable.js';

const fetchDataAndBuildTable = async () => {
	try {
		const tests = await fetchData('/fetch');
		tests.forEach(test => {
			buildTable(test);
		});
	} catch (error) {
		console.error('Error fetching data:', error);
	}	
};

fetchDataAndBuildTable();

document.getElementById('csvFile').addEventListener('change', function() {	
	var fileName = this.files[0].name;
	document.getElementById('fileLabel').innerText = fileName;
});

document.querySelector('.csv-upload').addEventListener('submit', async (e) => {
	e.preventDefault();

	const fileInput = document.getElementById('csvFile');
	if (fileInput.files.length === 0) {
	alert('Please select a CSV file.'); 
	return;
	}

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