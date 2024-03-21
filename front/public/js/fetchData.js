import mockData from './mockData.js'; 

const fetchData = async (url) => {
	const testMode = document.querySelector('meta[name="test-mode"]').getAttribute('content') === 'true';
	if (testMode) {
		return mockData;
	}
	
	try {
		const response = await fetch(url);
		const data = await response.json();
		return data;
	} catch (error) {
		console.error('Error fetching data:', error);
		throw error;
	}
};

export default fetchData;
