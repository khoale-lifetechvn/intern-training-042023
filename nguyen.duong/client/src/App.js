import './App.css';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import Body from './components/Body';
import Container from 'react-bootstrap/esm/Container';

function App() {

  return (
    <BrowserRouter>
      <Container>
        <Header />
        <Routes>
          <Route path="/table/:table_name" element={<Body />} />
        </Routes>
      </Container>
    </BrowserRouter>
  );
}

export default App;
