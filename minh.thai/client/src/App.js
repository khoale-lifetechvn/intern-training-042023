import logo from './logo.svg';
import './App.css';
import axios from "axios";
import { useEffect, useState } from 'react';
import { Table, Layout, Menu } from "antd";

const { Header, Content, Footer } = Layout;

function App() {
  // Khai báo các bảng dữ liệu cần hiển thị
  const tables = ['continents','countries','country_languages','country_stats','languages','regions']

  // Sử dụng useState hooks để lưu trữ dữ liệu và cột cho bảng dữ liệu hiển thị
  const [data, setData] = useState([])
  const [columns, setColumns] = useState([])

  // Hàm lấy dữ liệu từ API
  async function getData(table) {
    // Xây dựng URL cho API
    const url = "http://localhost:3001/" + `${table}`

    // Lấy thông tin cột của bảng dữ liệu
    await axios.get(url + "/columns").then(async res => {
      const data = await res.data
      setColumns(data)
    })

    // Lấy dữ liệu từ bảng dữ liệu
    await axios.get(url).then(async res => {
      const data = await res.data
      setData(data)
    });
  }

  // Sử dụng useEffect hook để lấy dữ liệu cho bảng dữ liệu đầu tiên khi ứng dụng được khởi chạy
  useEffect(() => {
    getData(tables[0]);
  }, [])

  // Sử dụng Ant Design Layout và Menu để tạo giao diện cho ứng dụng
  return (
    <Layout>
      <Header>
        <Menu
          theme='dark'
          mode="horizontal"
          // Tạo các mục trong menu tương ứng với các bảng dữ liệu
          items={tables.map((item, index) => {
            return {
              key: item,
              label: item,
              onClick: () => getData(tables[index])
            }
          })}
        />
      </Header>
      <Content>
        {/* Sử dụng Ant Design Table để hiển thị dữ liệu trong bảng */}
        <Table dataSource={data} columns={columns.map(item => {
          return { key: item.name, title: item.name, dataIndex: item.name }
        })} />
      </Content>
    </Layout>
  );
}

export default App;
