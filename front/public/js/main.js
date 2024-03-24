import fetchData from './fetchData.js';
import buildTestList from './buildTestList.js';
import listeners from './listeners.js';

export const fetchDataAndbuildTestList = async () => {
	try {
		if (!window.testsCache) {
			const tests = await fetchData('/fetch');
			
			window.testsCache = tests
			
			buildTestList(tests, 1);
		} else {
			buildTestList(window.testsCache, 1);
		}
	} catch (error) {
		console.error('Error when building tests list:', error);
	}
};

fetchDataAndbuildTestList();

listeners.handleSearchToken();
listeners.handleFileChange();
listeners.handleCsvUpload();
listeners.showTestDetails();
