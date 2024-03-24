import fetchData from './fetchData.js';
import buildTable from './buildTable.js';
import listeners from './listeners.js';

export const fetchDataAndBuildTable = async () => {
	try {
		if (!window.testsCache) {
			const tests = await fetchData('/fetch');
			window.testsCache = tests
			
			buildTable(tests);
		} else {
			buildTable(window.testsCache);
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
