import fetchData from './fetchData.js';
import buildTable from './buildTable.js';
import listeners from './listeners.js';

export const fetchDataAndBuildTable = async () => {
	try {
		if (!window.testsCach) {
			const tests = await fetchData('/fetch');
			window.testsCach = tests
			
			tests.forEach((test, idx) => {
				buildTable(test, idx);
			});
		} else {
			document.querySelector('#tables-list').innerHTML = ''
			window.testsCach.forEach((test, idx) => {
				buildTable(test, idx);
			});
		}
	} catch (error) {
		console.error('Error when building table:', error);
	}
};

fetchDataAndBuildTable();

listeners.handleSearchToken();
listeners.handleFileChange();
listeners.handleCsvUpload();
listeners.backToList();
