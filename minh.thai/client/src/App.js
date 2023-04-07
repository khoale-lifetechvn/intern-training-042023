import logo from './logo.svg';
import './App.css';
import  axios  from "axios";
import { useEffect, useState } from 'react';
import { Table, Layout, Menu } from "antd";
const { Header, Content, Footer } = Layout;
function App() {
  const tables = ['continents','countries','country_languages','country_stats','languages','regions']
  const [data,setData] = useState([])
  const [columns,setColumns] = useState([])

  async function getData(table) {
    const url = "http://localhost:3000/"+`${table}`
    console.log(url);
    await axios.get(url+"/columns").then(async res=> {
      const data = await res.data
      setColumns(data)
    })

    await axios.get(url).then(async res=> {
      const data = await res.data
      setData(data)
    });
  }


  useEffect(()=>{
    getData(tables[0]);
  },[])
  return (
    <Layout>
      <Header>
        <Menu
        theme='dark'
        mode="horizontal"
        items={tables.map((item,index)=>{
          return{
            key: item,
            label: item,
            onClick:()=>getData(tables[index])
          }
        })}
          />
      </Header>
      <Content>
      <Table dataSource={data} columns={columns.map(item=>{return{key: item.name, title: item.name, dataIndex: item.name}})}/>
      </Content>
    </Layout>
  );
}

export default App;
