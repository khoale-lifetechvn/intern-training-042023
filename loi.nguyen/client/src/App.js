function App() {
  function handleButtonClick(table) {
    window.location.href = `http://localhost:5000/api/?table=${table}`;
  }
  return (

      <div className="App">
        <button onClick={() => handleButtonClick('continents')}>Continents</button>
        <button onClick={() => handleButtonClick('countries')}>Countries</button>
        <button onClick={() => handleButtonClick('country_languages')}>Country Languages</button>
        <button onClick={() => handleButtonClick('country_stats')}>Country Stats</button>
        <button onClick={() => handleButtonClick('languages')}>Languages</button>
        <button onClick={() => handleButtonClick('regions')}>Regions</button>
      </div>
  );
}

export default App;