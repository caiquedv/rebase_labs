import fetchData from './fetchData.js';
import buildTable from './buildTable.js';
import { fetchDataAndBuildTable } from './main.js'

const listeners = {
	handleSearchToken: function () {
		document.querySelector('.search-token').addEventListener('submit', async (e) => {
			e.preventDefault();
			const token = e.target[0].value;

			if (!token) {
				alert('Please insert a token');
				return;
			}

			try {
				const dataPerToken = await fetchData(`/fetch/${token}`);

				document.getElementById('tables-list').innerHTML = '';

				buildTable(dataPerToken, 0);

				const backButton = document.querySelector('.back-list-none')
				backButton.classList.remove('back-list-none')
				backButton.classList.add('back-list')
			} catch (error) {
				console.error('Error building single table:', error);
			}
		});
	},

	handleFileChange: function () {
		document.getElementById('csvFile').addEventListener('change', function () {
			var fileName = this.files[0].name;
			document.getElementById('fileLabel').innerText = fileName;
		});
	},

	handleCsvUpload: function () {
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
					const msg = await response.json();
					alert(msg.done);
					document.getElementById('fileLabel').innerText = 'Import CSV file';
				} else {
					console.error('Failed to upload CSV file:', response.statusText);
				}
			} catch (error) {
				console.error('Error uploading CSV file:', error);
			}
		});
	},

	backToList: function () {
		const backToListButton = document.getElementById('back');
		backToListButton.addEventListener('click', () => {
			fetchDataAndBuildTable();
			backToListButton.classList.remove('back-list')
			backToListButton.classList.add('back-list-none')
		});
	}
};

export default listeners;