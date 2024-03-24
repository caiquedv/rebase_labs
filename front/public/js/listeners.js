import buildTestDetails from './buildTestDetails.js';
import { fetchDataAndbuildTestList } from './main.js'

const listeners = {
	handleSearchToken: function () {
		document.querySelector('.search-token').addEventListener('submit', async (e) => {
			e.preventDefault();

			const token = e.target[0].value;
			if (!token) {
				alert('Please insert a token');
				return;
			}

			const validToken = window.testsCache.filter(test => test.result_token === token);
			if (validToken.length == 0) {
				alert('Invalid token');
				return;
			}
			buildTestDetails(token);
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
				const response = await fetch('/fetch-csv', {
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

	backToList: function (backToListButton) {
		backToListButton.addEventListener('click', () => {
			document.getElementById('tables-list').innerHTML = '';
			document.getElementById('token').value = ''
			fetchDataAndbuildTestList();
		});
	},

	showTestDetails: function () {
		document.getElementById('tables-list').addEventListener('click', function (ev) {
			const clickedRow = ev.target.closest('tr');
			if (clickedRow) {
				const token = clickedRow.dataset.token;
				token && buildTestDetails(token);
			}
		});
	}
};

export default listeners;