import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Table } from 'antd';

const Continents = () => {
  const [data, setData] = useState([]);

  useEffect(() => {
    axios.get('http://localhost:3001/continents').then((response) => {
      setData(response.data);
    });
  }, []);

  const columns = [
    {
      title: 'ID',
      dataIndex: 'id',
      key: 'id',
    },
    {
      title: 'Continent',
      dataIndex: 'continent',
      key: 'continent',
    },
  ];

  return <Table dataSource={data} columns={columns} />;
};

export default Continents;