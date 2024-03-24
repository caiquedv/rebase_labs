import fetchData from './fetchData.js';
import buildTestList from './buildTestList.js';
import listeners from './listeners.js';

export const fetchDataAndbuildTestList = async () => {
	try {
		if (!window.testsCache) {
			const tests = await fetchData('/fetch');
			window.testsCache = tests
			
			buildTestList(tests);
		} else {
			buildTestList(window.testsCache);
		}
	} catch (error) {
		console.error('Error when building tests list:', error);
	}
};

fetchDataAndbuildTestList();

listeners.handleSearchToken();
listeners.handleFileChange();
listeners.handleCsvUpload();
listeners.backToList();
listeners.showTestDetails();
