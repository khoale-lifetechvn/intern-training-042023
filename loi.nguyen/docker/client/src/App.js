import './App.css';
import { useEffect, useState } from 'react';
import axios from 'axios'
import { Layout,Menu,Skeleton,Table } from "antd";

function App() {
  const { Header, Content } = Layout;
  const [isBusy,setBusy] = useState([true])
  const [data, setData] = useState([])
  const [columns, setColumns] = useState([])
  
  const tables = ["continents", "countries", "country_languages", "country_stats","languages","regions"];

  const [table, setTable] = useState("");
  const [values, setValues] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();
    const data = {
      table: table,
      values: values.map((value) => `'${value}'`).join(","),
    };
    try {
      const response = await axios.post("http://localhost:5000/api/insertData", data);
      console.log(response);
    } catch (error) {
      console.error(error);
    }
  };

  const handleValueChange = (index, value) => {
    const newValues = [...values];
    newValues[index] = value;
    setValues(newValues);
  };







  async function fetchData(table){
    await axios.get("http://localhost:5000/api/columns",{params: {table: table}}).then( async (res)=>{
    const data = await res.data
    setColumns(data)
    }).catch((err)=>{
    console.log(err)
  })

  await axios.get("http://localhost:5000/api",{params: {table: table}}).then( async (res)=>{
      const data = await res.data
      setData(data)
    }).catch((err)=>{
      console.error(err);
    })
  setBusy(false)
  }




  useEffect(()=>{
    fetchData(tables[1]);
  },[])


  return (
    <Layout>
  
        <Menu
          mode='horizontal'
          defaultSelectedKeys = {[tables[1]]}
          items = {tables.map((e,index) => {
            return {
              key: e,
              label: e.toUpperCase(),
              onClick: ()=>{fetchData(tables[index]);}
            };
          })}
        />
    
      <Content>
      {/* Form to insert */}
      <form onSubmit={handleSubmit}>
      <label>
        Table:
        <input type="text" value={table} onChange={(e) => setTable(e.target.value)} />
      </label>
      <br />
      {/* {columns.map((column, index) => (
        <label key={index}>
          {column}:
          <input
            type="text"
            value={values[index] || ""}
            onChange={(e) => handleValueChange(index, e.target.value)}
          />
        </label>
      ))} */}
      <br />
      <button type="submit">Insert Data</button>
    </form>
     {/* Table show data */}
      {isBusy? <Skeleton active/> : 
    <table>
    <thead>
      <tr>
        {Object.keys(data[0]).map(key => <th key={key}>{key}</th>)}
      </tr>
    </thead>
    <tbody>
      {data.map(row => (
        <tr key={row.region_id}>
          {Object.values(row).map(value => <td key={value}>{value}</td>)}
        </tr>
      ))}
    </tbody>
  </table>
  }
      </Content>
    </Layout>
  );
}

export default App;
