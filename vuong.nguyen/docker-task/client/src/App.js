import './App.css';
import { useEffect, useState } from 'react';
import axios from 'axios'
import { Layout,Menu,Skeleton,Table } from "antd";

function App() {
  const { Header, Content } = Layout;
  const [isBusy,setBusy] = useState([true])
  const [data, setData] = useState([])
  const [columns, setColumns] = useState([])
  const tables = ["continents","countries","country_languages","languages","regions","country_stats"]

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
      <Header>
        <Menu
          theme='dark'
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
      </Header>
      <Content>
      {isBusy? <Skeleton active/> : 
      <Table columns={columns.length>0&&columns.map((item)=>{
      return {
        title: item.toUpperCase(),
        dataIndex: item,
        key: item,
      }
    })} dataSource={data.length>0 && data} rowKey={columns[0]}/>}
      </Content>
    </Layout>
  );
}

export default App;
