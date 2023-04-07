import { useEffect, useState } from "react"
import Table from 'react-bootstrap/Table';
import axios from 'axios';
import { Container } from "react-bootstrap";


const Card = (url) =>{
    const [data,setData] = useState([])
    useEffect(()=>{
        const getData = async () =>{
            const res = await axios.get(url)
            setData(res.data)
            console.info(res.data)
        }
        getData()
    },[])

    return(
        <Container>
        <Table striped bordered hover>
            <thead>
                <tr>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>

            </tbody>
        </Table>
        </Container>
    )

}

export default Card