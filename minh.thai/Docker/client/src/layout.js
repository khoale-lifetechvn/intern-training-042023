import React from 'react';
import { Layout } from 'antd';

const { Header, Content } = Layout;

const CustomLayout = ({ children }) => {
  return (
    <Layout>
      <Header>
        <div className='logo' />
        <Menu theme='dark' mode='horizontal' defaultSelectedKeys={['1']}>
          <Menu.Item key='1'>Continents</Menu.Item>
          <Menu.Item key='2'>Countries</Menu.Item>
          <Menu.Item key='3'>Country Languages</Menu.Item>
          <Menu.Item key='4'>Country Stats</Menu.Item>
          <Menu.Item key='5'>Languages</Menu.Item>
          <Menu.Item key='6'>Regions</Menu.Item>
        </Menu>
      </Header>
      <Content style={{ padding: '0 50px' }}>{children}</Content>
    </Layout>
  );
};

export default CustomLayout;