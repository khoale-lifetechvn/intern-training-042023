import {   Container, Nav, Navbar} from "react-bootstrap"
import Card from "./Card"
import { useEffect, useState } from "react"
import axios from 'axios';

const Header = () => {
    let url = "http://localhost:3001"
    const [table,setTable] = useState([])
    let urltable = "http://localhost:3001/api/table"
    
    useEffect(()=>{
        const loadTable = async ()=>{
            const res = await axios.get("http://localhost:3001/api/table")
            console.log(res)
            const data = await res.data
            console.log(data)
            setTable(data)
        }
        loadTable()
    },[])
    return(
    <>
        {/* <Card url={`url${i}`} /> */}
        <Navbar bg="light" variant="light">
        <Container>
          <Nav className="me-auto">
        {table.map((i)=><Nav.Link  href={`${url}/${i.TABLE_NAME}`} >{i.TABLE_NAME}</Nav.Link>)} 
          </Nav>
        </Container>
      </Navbar>
      {/* <Card  /> */}
    </>
    )
}

export default Header