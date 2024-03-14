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

export default fetchData;
