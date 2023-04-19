import axios from "axios"
import { useEffect, useState } from "react"
import Container from "react-bootstrap/esm/Container"
import { useParams } from "react-router-dom"
import Table from 'react-bootstrap/Table';

const Body = () => {
    const { table_name } = useParams()
    const [columns, setColumns] = useState([])
    const [records, setRecords] = useState([])
    let url = "http://localhost:3001"

    const getData = () => {
        axios.get(`${url}/table_columns/${table_name}`)
            .then((res) => {
                const dt = res.data.data
                return dt
            }).then((dt) => setColumns(dt))
    }

    const getRecords = () => {
        axios.get(`${url}/table/${table_name}`)
            .then((res) => {
                const dt = res.data.data
                return dt
            }).then((dt) => {
                console.log(dt)
                setRecords(dt)
            })}

    useEffect(() => {
        getData()
        getRecords()
    }, [table_name])

    return (
        <Container>
            <Table striped bordered hover className='mt-3'>
                <thead>
                    <tr>
                        {columns.map((item) => <th>{item.COLUMN_NAME}</th>)}
                    </tr>
                </thead>
                <tbody>
                    {records.map(obj => {
                        const array = Object.values(obj)
                        return <tr>{array.map((i) => <td>{i}</td>)}</tr>
                    })}
                </tbody>
            </Table>
        </Container>
    )
}

export default Body