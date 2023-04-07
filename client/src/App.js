import './App.css';

function App() {
  const table = ['countinents','countries','country_languages']
  let url = "http://localhost:3001"
  return (
   <>
    <ul>
      {table.map((i)=><a href={`${url}/${i}`}>{i}</a>)}
    </ul>
   </>
  );
}

export default App;
