import fetchData from './fetchData.js';
import buildTable from './buildTable.js';
import listeners from './listeners.js';

const fetchDataAndBuildTable = async () => {
	try {
		const tests = await fetchData('/fetch');
		tests.forEach((test, idx) => {
			buildTable(test, idx);
		});
	} catch (error) {
		console.error('Error when building table:', error);
	}	
};
 
fetchDataAndBuildTable();

listeners.handleSearchToken();
listeners.handleFileChange();
listeners.handleCsvUpload();
